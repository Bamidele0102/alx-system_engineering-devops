#!/usr/bin/env ruby

log_file_path = ARGV[0]

if log_file_path.nil? || !File.exist?(log_file_path)
  puts "Usage: ./statistics_script.rb <log_file_path>"
  exit 1
end

log_entries = File.read(log_file_path).scan(/\[SENDER:(.*?)\],\[RECEIVER:(.*?)\],\[FLAGS:(.*?)\]/)

log_entries.each do |entry|
  sender = entry[0]
  receiver = entry[1]
  flags = entry[2]
  puts "#{sender},#{receiver},#{flags}"
end
