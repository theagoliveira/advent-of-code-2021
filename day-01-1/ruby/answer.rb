# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def main
    data = self.class.read_input_file.split("\n").map(&:to_i)
    result = 0

    (1...data.size).each do |index|
      result += 1 if data[index] > data[index - 1]
    end

    result
  end
end

puts Answer.new.main
