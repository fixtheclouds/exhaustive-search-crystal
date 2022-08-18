module ExhaustiveSearch
  class CharGenerator
    def initialize(charset : Array(String))
      @charset = charset
      @i = 0
    end

    def next
      @i += 1
      @charset[@i]
    end

    def next?
      @i + 1 != @charset.size
    end

    def current
      @charset[@i]
    end

    def reset
      @i = 0
    end

    def last
      @charset.last
    end

    def end?
      @i == @charset.size
    end
  end
end
