# frozen_string_literal: true

def three_window_sum(array, index)
  array[index] + array[index + 1] + array[index + 2]
end

input_file = File.open('./input.txt')
raw_input = input_file.read
input_file.close
input_array = raw_input.split("\n").map(&:to_i)

result = 0

(1...(input_array.size - 2)).each do |i|
  if three_window_sum(input_array, i) > three_window_sum(input_array, i - 1)
    result += 1
  end
end

puts result
