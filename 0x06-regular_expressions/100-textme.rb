#!/usr/bin/env ruby

if ARGV.empty?
	puts "Usage: #{$PROGRAM_NAME} {LOG_FILE_PATH}"
	exit 1
end

FILE.foreach(ARGV[0]) do |line|
	match_data = line.match(/\[from:(\S+)\] \[to:(\S+)\] \[flags:([^\]]+)\]/)

	if mathc_data
		sender = match_data[1]
		receiver = match_data[2]
		flags = match_data[3]

		puts "#{sender},#{receiver},#{flags}"
	end
end
