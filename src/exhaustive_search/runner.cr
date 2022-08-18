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
      @limit = limit
      @characters = characters

      validate_limit
      validate_hash
    end

    def call
      original_string = nil
      measure = Benchmark.measure do
        original_string = Processor.new(charset, hash, limit).call
      end
      puts "String found: #{original_string}" if original_string
      puts measure
    end

    private def validate_limit
      raise "My possibilities are limited, please use a limit not greater than 5" if limit > 5
    end

    private def validate_hash
      raise "Invalid MD5 hash format" unless /^[0-9a-f]{32}$/ =~ hash
    end

    private def charset
      CHARSET_MAPPING[characters]
    end
  end
end
