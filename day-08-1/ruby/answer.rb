# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def main
    entries = self.class.read_input_file.split("\n").map do |entry|
      entry.split(' | ')
    end

    four_digit_output_values = entries.map(&:last).map(&:split)

    four_digit_output_values.flatten.select do |value|
      [2, 3, 4, 7].include? value.size
    end.size
  end
end

puts Answer.new.main
