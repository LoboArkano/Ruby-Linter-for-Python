#!/usr/bin/env ruby
require_relative '../lib/scanner.rb'
main = nil

loop do
  print 'Enter the path file: '
  path_file = gets.chomp
  main = Scanner.scan_file(path_file)
  break if !main.file.length.zero? && !main.file[0].length.zero?
end

main.linter_on
main.linter_errors.each { |key, value| puts "Line #{key}:  #{value}" }
