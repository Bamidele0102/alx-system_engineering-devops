#!/usr/bin/env ruby

result = ARGV[0].scan(/School/).join

if result.empty?
  puts "$"
else
  puts "#{result}$"
end
