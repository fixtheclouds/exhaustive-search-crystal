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

    FIBER_COUNT = 16

    def initialize(hash : String, limit : Int8, characters : String)
      @hash = hash
      @limit = limit
      @characters = characters
    end

    def call
      per_fiber = (total_combinations_count / FIBER_COUNT).ceil
    end

    private def charset
      CHARSET_MAPPING[@characters]
    end

    private def total_combinations_count
      ALL.size ** @limit
    end
  end
end
