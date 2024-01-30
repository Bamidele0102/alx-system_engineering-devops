#!/usr/bin/env ruby

result = ARGV[0].scan(/^\d{10}$/).join

if result.empty?
  puts "$"
else
  puts "#{result}$"
end
