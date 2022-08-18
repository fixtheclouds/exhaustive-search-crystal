require "digest/md5"

module ExhaustiveSearch
  class Processor
    # TODO: pass string ranges, not absolute indices
    def initialize(charset : Array(String), range : Range(UInt64, UInt64), target : String, fiber_id : UInt16)
      @charset = charset
      @range = range
      @target = target
      @fiber_id = fiber_id
    end

    def call
      @range.each_with_index do |position, i|
        string = position_to_string(position)
        md5 = Digest::MD5.hexdigest(string)
        return string if @target == md5

        # TODO: dynamic breakpoints
        if i % 100000 == 0
          puts "fiber #{@fiber_id}: #{string}, hash: #{md5}"
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
