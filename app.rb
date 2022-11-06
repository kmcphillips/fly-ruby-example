# frozen_string_literal: true
require "active_support/all"
require "mysql"
require "webrick"
require "sinatra"
require "fileutils"

Global = Class.new do
  attr_accessor :mysql_version
end.new

puts "app started..."

test_file = Pathname.new(File.dirname(__FILE__)).expand_path.join("running.txt")
puts "creating test file #{test_file}..."
FileUtils.touch(test_file)

db = Mysql.connect(ENV["DATABASE_URL"])
db.query("SHOW VARIABLES LIKE 'version'").each do |(name, value)|
  Global.mysql_version = value
end

Thread.new do
  puts "ticking..."
  loop do
    puts "  tick #{ Time.now.to_i } #{ Time.current }"
    sleep 1
  end
end

puts "launching web app..."
class WebApp < Sinatra::Application
  get "/" do
    "MySQL #{ Global.mysql_version } #{ Time.now.to_i } #{ Time.current }"
  end
end
WebApp.run!
