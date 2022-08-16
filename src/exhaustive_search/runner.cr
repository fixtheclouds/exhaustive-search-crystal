module ExhaustiveSearch
  class Runner
    EMPTY = ["\0"]
    LOWERCASE_LETTERS = EMPTY | [*"a".."z"]
    UPPERCASE_LETTERS = EMPTY | [*"A".."Z"]
    NUMERIC = EMPTY | [*"0".."9"]
    SYMBOLS = EMPTY | [*" ".."/", *":".."@", *"[".."`", *"{".."\x7F"]
    ALPHANUMERIC = LOWERCASE_LETTERS | UPPERCASE_LETTERS | NUMERIC
    ALL = ALPHANUMERIC | SYMBOLS

    def initialize(hash : String, limit : Int8, characters : String)
      @hash = hash
      @limit = limit
      @characters = characters
    end

    def call
      ALL
    end
  end
end
