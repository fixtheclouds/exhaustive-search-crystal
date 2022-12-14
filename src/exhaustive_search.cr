require "option_parser"
require "./exhaustive_search/runner"

module ExhaustiveSearch
  # TODO: Put your code here
end

hash = ""
limit = 5
characters = "alphanumeric"
option_parser = OptionParser.parse do |parser|
  parser.on "-h hash", "--hash=hash", "hash to guess" do |value|
    hash = value
  end

  parser.on "-l limit", "--limit=10", "character limit, default is 5" do |value|
    limit = value
  end

  parser.on "-c character_set", "--characters=character_set", "character set, defaults to alphanumeric" do |value|
    characters = value
  end
end

raise "Target hash must be set" if hash.blank?

ExhaustiveSearch::Runner.new(hash, UInt8.new(limit), characters).call
