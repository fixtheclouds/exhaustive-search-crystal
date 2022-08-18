require "./char_generator"

module ExhaustiveSearch
  class StringGenerator
    property generators : Array(CharGenerator)

    def initialize(charset : Array(String), count : Int32)
      @charset = charset
      @count = count
      @generators = Array.new(count) { CharGenerator.new(charset) }
      reset
      @step = 0
    end

    def next
      @step += 1
      trigger_next_generator(0)

      value
    end

    def end?
      @generators[@count - 1].current == @charset.last
    end

    def value
      @generators.reverse.map(&.current).join
    end

    def step
      @step
    end

    def reset
      @step = 0
      @generators.each(&.reset)
    end

    private def trigger_next_generator(number)
      if @generators[number].next?
        @generators[number].next
      else
        @generators[number].reset
        trigger_next_generator(number + 1)
      end
    end
  end
end
