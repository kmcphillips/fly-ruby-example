# frozen_string_literal: true
require "active_support/all"
require "fileutils"

puts "app started..."

test_file = Pathname.new(File.dirname(__FILE__)).expand_path.join("running.txt")
puts "creating test file #{test_file}..."
FileUtils.touch(test_file)

puts "ticking..."
loop do
  puts "  tick #{ Time.now.to_i } #{ Time.current }"
  sleep 1
end
