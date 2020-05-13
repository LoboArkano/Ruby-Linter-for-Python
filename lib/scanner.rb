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
      withespace_before_csc(index, line)
      index += 1
    end
  end

  def max_line_length(index, line)
    @linter_errors[index + 1] = "Max line length is 79, yours line is #{line.length}" if line.length > 79
  end

  def import_single_line(index, line)
    @linter_errors[index + 1] = 'Imports should be on separate line' if line.match(/^import.+,.*/)
  end

  def withespace_inside_pbb(line_index, line)
    matches1 = '{[('
    matches2 = '}])'
    index = 0
    line.split('').each do |char|
      if matches1.include?(char) && line[index + 1] == ' '
        @linter_errors[line_index + 1] = 'Whitespace inside after parentheses, brackets or braces'
        break
      end
      if matches2.include?(char) && line[index - 1] == ' '
        @linter_errors[line_index + 1] = 'Whitespace inside before parentheses, brackets or braces'
        break
      end
      index += 1
    end
  end

  def withespace_before_csc(line_index, line)
    matches = ',;:'
    index = 0
    line.split('').each do |char|
      if matches.include?(char) && line[index - 1] == ' '
        @linter_errors[line_index + 1] = 'Whitespace before a comma, semicolon, or colon'
        break
      end
      index += 1
    end
  end
end
