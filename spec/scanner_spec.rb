# rubocop:disable Layout/LineLength

require_relative '../lib/scanner.rb'

describe 'Scanner' do
  let(:python_file) { Scanner.scan_file('test.py') }
  describe '#scan_file' do
    it 'Return array with the lines of the file' do
      expect(python_file.file[0]).to eql('import sys, os')
      expect(python_file.file[-1]).to eql('nOn = 5')
    end
    it 'Return message error when the user input is incorrect' do
      expect { Scanner.scan_file('bad_path') }.to output("No such file or directory\n").to_stdout
    end
  end

  describe '#max_line_length' do
    let(:line) { "print('An electronic calculator is typically a portable electronic device used to perform   calculations, ranging from basic arithmetic to complex mathematics.')" }
    let(:short_line) { "print('Hello World!')" }
    it 'Insert key and value in the hash when the line length is greater than 79' do
      expect { python_file.max_line_length(0, line) }.to change(python_file, :linter_errors)
    end
    it 'Ignore lines shorter than 79' do
      expect { python_file.max_line_length(0, short_line) }.not_to change(python_file, :linter_errors)
    end
  end

  describe '#import_single_line' do
    let(:line) { 'import sys, os' }
    it 'Insert key and value in the hash when more of one import is make it in one line' do
      expect { python_file.import_single_line(0, line) }.to change(python_file, :linter_errors)
      expect(python_file.linter_errors[1]).to eql('Imports should be on separate line')
    end
    let(:line2) { 'while True:' }
    it "Return nil when the line don't start with import" do
      expect { python_file.import_single_line(0, line2) }.not_to change(python_file, :linter_errors)
      expect(python_file.import_single_line(0, line2)).to eql(nil)
    end
  end

  describe '#withespace_inside_pbb' do
    let(:line) { 'x = ( x + 1 ) - 5' }
    let(:line2) { "print('Hello World!')" }
    it 'Insert key and value in the hash when whitespace inside after parentheses, brackets or braces' do
      expect { python_file.withespace_inside_pbb(0, line) }.to change(python_file, :linter_errors)
      expect(python_file.linter_errors[1]).to eql('Whitespace inside after parentheses, brackets or braces')
    end
    it "Return nil if the line don't have space inside of parentheses, brackets or braces" do
      expect { python_file.withespace_inside_pbb(0, line2) }.not_to change(python_file, :linter_errors)
      expect(python_file.linter_errors[1]).to eql(nil)
    end
  end

  describe '#whitespace_before_operator' do
    let(:line) { 'x             = 1' }
    let(:line2) { 'y = 2' }
    it 'Insert key and value in the hash when more than one space around an assignment operator' do
      expect { python_file.whitespace_before_operator(0, line) }.to change(python_file, :linter_errors)
      expect(python_file.linter_errors[1]).to eql('More than one space around an assignment operator')
    end
    it 'Return nil if the there is no more than one space around an assignment operator' do
      expect { python_file.whitespace_before_operator(0, line2) }.not_to change(python_file, :linter_errors)
      expect(python_file.linter_errors[1]).to eql(nil)
    end
  end

  describe '#names_to_avoid' do
    let(:line) { 'I = 5' }
    let(:line2) { 'N = 9' }
    it "Insert key and value in the hash when a variable name is 'l','O' or 'I'" do
      expect { python_file.names_to_avoid(0, line) }.to change(python_file, :linter_errors)
      expect(python_file.linter_errors[1]).to eql("Never use the characters 'l' (lowercase letter el), 'O' (uppercase letter oh), or 'I' (uppercase letter eye) as single character variable names.")
    end
    it "Return nil if the variable name is diferent from 'l','O' and 'I'" do
      expect { python_file.names_to_avoid(0, line2) }.not_to change(python_file, :linter_errors)
      expect(python_file.linter_errors[1]).to eql(nil)
    end
  end
end

# rubocop:enable Layout/LineLength
