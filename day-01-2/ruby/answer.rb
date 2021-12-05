# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def main
    data = self.class.read_input_file.split("\n").map(&:to_i)
    result = 0

    (1...(data.size - 2)).each do |i|
      if three_window_sum(data, i) > three_window_sum(data, i - 1)
        result += 1
      end
    end

    result
  end

  def three_window_sum(array, index)
    array[index] + array[index + 1] + array[index + 2]
  end
end

puts Answer.new.main
