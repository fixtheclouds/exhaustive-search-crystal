require "benchmark"
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

    property hash : String
    property limit : UInt8
    property characters : String

    def initialize(hash : String, limit : UInt8, characters : String)
      @hash = hash
      if limit > 5
        raise "My possibilities are limited, please use a limit not greater than 5"
      end

      @limit = limit
      @characters = characters
    end

    def call
      original_string = nil
      measure = Benchmark.measure do
        original_string = Processor.new(charset, hash, limit).call
      end
      puts "String found: #{original_string}" if original_string
      puts measure
    end

    private def charset
      CHARSET_MAPPING[characters]
    end
  end
end
