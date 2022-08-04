require "option_parser"
require "./pes/runner"

module Pes
  # TODO: Put your code here
end

hash = ""
limit = 10
characters = "alphanumeric"
option_parser = OptionParser.parse do |parser|
  parser.on "-h hash", "--hash=hash", "hash to guess" do |value|
    hash = value
  end

  parser.on "-l limit", "--limit=10", "character limit, default is 10" do |value|
    limit = value
  end

  parser.on "-c character_set", "--characters=character_set", "character set, defaults to alphanumeric" do |value|
    characters = value
  end
end

Pes::Runner.new(hash, Int8.new(limit), characters).call
