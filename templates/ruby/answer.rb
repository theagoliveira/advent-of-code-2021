# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def parse_input(input)
    input.split("\n")
  end

  def main
    data = parse_input(self.class.read_input_file)
    result = 0

    # CODE

    result
  end
end

puts Answer.new.main
