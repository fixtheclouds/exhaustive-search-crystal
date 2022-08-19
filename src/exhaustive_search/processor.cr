require "digest/md5"
require "./string_generator"

module ExhaustiveSearch
  class Processor
    property charset : Array(String)
    property target : String
    property limit : UInt8

    def initialize(charset : Array(String), target : String, limit : UInt8)
      @charset = charset
      @target = target
      @limit = limit
    end

    def call
      generator = StringGenerator.new(charset, limit)
      while !generator.end?
        str = generator.next
        md5 = Digest::MD5.hexdigest(str)
        if generator.step % breakpoint == 0
          puts "searching: #{str}, hash: #{md5}"
        end
        return str if target == md5
      end

      puts "Fail :("
    end

    private def breakpoint
      charset.size ** (limit - 1)
    end
  end
end
