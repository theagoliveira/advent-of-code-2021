# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def main
    data = self.class.read_input_file.split("\n")
    result = 0

    # CODE

    result
  end
end

puts Answer.new.main
