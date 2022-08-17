module ExhaustiveSearch
  class Processor
    def initialize(charset : Array(String), range : Range(UInt64, UInt64), char_count : UInt8, number : UInt16)
      @charset = charset
      @range = range
      @char_count =char_count
      @number = number
    end

    def call
      @range.each_with_index do |position, i|
        if i % 1000 == 0
          puts "fiber #{@number}: #{position_to_string(position)}"
        end
      end
    end

    private def base
      @charset.size
    end

    private def position_to_string(position : UInt64) : String
      str : String = ""
      n = position
      while n > 0
        str = str + @charset[n % base]
        n = n // base
      end
      str
    end
  end
end
