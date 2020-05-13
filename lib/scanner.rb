class Scanner
  attr_reader :file, :linter_errors

  def initialize(file)
    @file = file
    @linter_errors = {}
  end

  def self.scan_file(path_file)
    Scanner.new(IO.readlines(path_file, chomp: true))
  end

  def linter_on
    index = 0
    @file.each do |line|
      max_line_length(index, line)
      import_single_line(index, line)
      withespace_inside_pbb(index, line)
      index += 1
    end
  end

  def max_line_length(index, line)
    @linter_errors[index] = "Max line length is 79, yours line is #{line.length}" if line.length > 79
  end

  def import_single_line(index, line)
    @linter_errors[index] = 'Imports should be on separate line' if line.match(/^import.+,.*/)
  end

  def withespace_inside_pbb(line_index, line)
    matches1 = '{[('
    matches2 = '}])'
    index = 0
    line.class
    line = line.split('')
    line.each do |char|
      if matches1.include?(char) && line[index + 1] == ' '
        @linter_errors[line_index] = 'Whitespace inside after parentheses, brackets or braces'
        break
      end
      if matches2.include?(char) && line[index - 1] == ' '
        @linter_errors[line_index] = 'Whitespace inside before parentheses, brackets or braces'
        break
      end
      index += 1
    end
  end
end
