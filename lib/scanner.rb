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
      index += 1
    end
  end

  def max_line_length(index, line)
    @linter_errors[index] = "Max line length is 79, yours line is #{line.length}" if line.length > 79
  end

  def import_single_line(index, line)
    @linter_errors[index] = 'Imports should be on separate line' if line.match(/^import.+,.*/)
  end
end
