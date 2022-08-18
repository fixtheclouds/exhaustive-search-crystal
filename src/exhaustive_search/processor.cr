require "digest/md5"

module ExhaustiveSearch
  class Processor
    property charset : Array(String)
    property target : String
    property limit : UInt64

    def initialize(charset : Array(String), target : String, limit : UInt64)
      @charset = charset
      @target = target
      @limit = limit
    end

    def call
      range.each_with_index do |position, i|
        string = position_to_string(position)
        md5 = Digest::MD5.hexdigest(string)
        return string if target == md5

        if i % breakpoint == 0
          puts "searching: #{string}, hash: #{md5}"
        end
      end
    end

    private def base
      charset.size
    end

    private def breakpoint
      charset.size ** (limit - 1)
    end

    private def range
      0_u64..(charset.size ** limit).to_u64
    end

    # TODO: enhance algorhytm and remove this
    private def position_to_string(position : UInt64) : String
      str : String = ""
      n = position
      while n > 0
        str = charset[n % base] + str
        n = n // base
      end
      str
    end
  end
end
