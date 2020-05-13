require_relative '../lib/scanner.rb'

describe 'Scanner' do
  describe '#scan_file' do
    it 'Return array with the lines of the file' do
      python_file = Scanner.scan_file('test.py')
      expect(python_file.file[0]).to eql('import sys, os')
      expect(python_file.file[-1]).to eql('nOn = 5')
    end
    it 'Return message error when the user input is incorrect' do
      expect { Scanner.scan_file('bad_path') }.to output("No such file or directory\n").to_stdout
    end
  end
end
