#!/usr/bin/env ruby

pattern = /School/

if ARGV.length == 1
  input = ARGV[0]
  match = input.match(pattern)

  if match
    puts "#{match[0]}$"
  else
    puts "$"
  end
else
  puts "Usage: ./0-simply_match_school.rb <string>"
end
