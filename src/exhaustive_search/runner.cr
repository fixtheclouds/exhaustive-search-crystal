require "./processor"

module ExhaustiveSearch
  class Runner
    EMPTY = ["\0"]
    LOWERCASE_LETTERS = EMPTY | [*"a".."z"]
    UPPERCASE_LETTERS = EMPTY | [*"A".."Z"]
    NUMERIC = EMPTY | [*"0".."9"]
    SYMBOLS = EMPTY | [*" ".."/", *":".."@", *"[".."`", *"{".."\x7F"]
    ALPHANUMERIC = LOWERCASE_LETTERS | UPPERCASE_LETTERS | NUMERIC
    ALL = ALPHANUMERIC | SYMBOLS

    CHARSET_MAPPING = {
      "numbers" => NUMERIC,
      "alphanumeric" => ALPHANUMERIC,
      "full" => ALL
    }

    FIBER_COUNT = 16_u16

    property hash : String
    property limit : UInt8
    property characters : String
    property per_fiber : UInt64
    property max_position : UInt64

    def initialize(hash : String, limit : UInt8, characters : String)
      @hash = hash
      @limit = limit
      @characters = characters
      @per_fiber = (total_combinations_count / FIBER_COUNT).ceil.to_u64
      @max_position = (total_combinations_count - 1).to_u64
    end

    def call
      original_string = ""
      (0_u16...FIBER_COUNT).map do |i|
        range : Range(UInt64, UInt64) = lower_boundary(i)..upper_boundary(i)
        spawn do
          result = Processor.new(charset, range, hash, i + 1).call
          original_string = result if result
        end
      end

      Fiber.yield
      puts "String found: #{original_string}"
    end

    private def charset
      CHARSET_MAPPING[characters]
    end

    private def total_combinations_count : UInt64
      (charset.size ** limit).to_u64
    end

    private def upper_boundary(fiber_number) : UInt64
      # Stop iterating at the end of range to avoid threspassing it
      return max_position if fiber_number == FIBER_COUNT - 1

      # Take the beginning of the next chuck minus 1 to avoid intersection
      (per_fiber * (fiber_number + 1)) - 1
    end

    private def lower_boundary(fiber_number) : UInt64
      per_fiber * fiber_number
    end
  end
end
