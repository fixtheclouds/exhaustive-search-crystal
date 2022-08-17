module ExhaustiveSearch
  class Processor
    def initialize(charset : Array(String), range : Range(UInt64, UInt64), char_count : UInt8)
      @charset = charset
      @range = range
      @char_count =char_count
      puts "output from fiber, range: #{range.min}..#{range.max}"
    end
  end
end
