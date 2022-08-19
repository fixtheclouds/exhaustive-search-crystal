require "digest/md5"

module ExhaustiveSearch
  class Processor
    property charset : Array(String)
    property target : String
    property limit : UInt8
    property chars : Array(String)
    property step : UInt64

    def initialize(charset : Array(String), target : String, limit : UInt8)
      @charset = charset
      @target = target
      @limit = limit
      @chars = Array.new(limit) { charset.first }
      @step = 0
    end

    def call
      while !max_value_reached?
        md5 = Digest::MD5.hexdigest(full_string)
        if @step % breakpoint == 0
          puts "searching: #{full_string}, hash: #{md5}"
        end
        return full_string if target == md5

        @step += 1
        increment_string(0)
      end

      puts "Not found :("
    end

    private def breakpoint
      charset.size ** (limit - 1)
    end

    private def full_string
      chars.reverse.join
    end

    private def increment_string(number)
      if chars[number] != charset.last
        cur_index = charset.index(chars[number]) || 0
        chars[number..number] = charset[cur_index + 1]
      else
        chars[number..number] = charset.first
        increment_string(number + 1)
      end
    end

    private def max_value_reached?
      chars.last == charset.last
    end
  end
end
