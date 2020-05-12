#!/usr/bin/env ruby

loop do
  print 'Enter the path file: '
  path_file = gets.chomp
  file = IO.readlines(path_file, chomp: true)
  break if !file.length.zero? && !file[0].length.zero?
end
