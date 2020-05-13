# rubocop:disable Layout/LineLength

class Scanner
  attr_reader :file, :linter_errors

  def initialize(file)
    @file = file
    @linter_errors = {}
  end

  def self.scan_file(path_file)
    Scanner.new(IO.readlines(path_file, chomp: true))
  rescue Errno::ENOENT
    puts 'No such file or directory'
    Scanner.new([''])
  end

  def linter_on
    index = 0
    @file.each do |line|
      max_line_length(index, line)
      import_single_line(index, line)
      withespace_inside_pbb(index, line)
      withespace_before_csc(index, line)
      whitespace_before_operator(index, line)
      names_to_avoid(index, line)
      check_identation(index, line)
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

  def whitespace_before_operator(index, line)
    @linter_errors[index + 1] = 'More than one space around an assignment operator' if line.match(%r{.*\s{2,}(=|\+=|-=|\*=|\/=|\/\/=|%=|\*\*=).*})
  end

  def names_to_avoid(index, line)
    return if blank_line?(line)

    line = first_word(line)
    @linter_errors[index + 1] = "Never use the characters 'l' (lowercase letter el), 'O' (uppercase letter oh), or 'I' (uppercase letter eye) as single character variable names." if line[0].match(/^(I|l|O)$/)
  end

  def blank_line?(line)
    return true if line.length.zero?

    false
  end

  def first_word(line)
    line.split(' ')
  end

  def check_identation(index, line)
    return if blank_line?(line)

    count_space = 0
    line.split('').each do |char|
      break if char != ' '

      count_space += 1
    end
    @linter_errors[index + 1] = 'Unindent does not match any outer indentation level' if count_space % 4 != 0
  end
end

# rubocop:enable Layout/LineLength
