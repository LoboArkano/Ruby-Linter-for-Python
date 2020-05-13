class Scanner
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def self.scan_file(path_file)
    Scanner.new(IO.readlines(path_file, chomp: true))
  end
end
