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
end

# rubocop:enable Layout/LineLength
