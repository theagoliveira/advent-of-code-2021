# frozen_string_literal: true

input_file = File.open('./input.txt')
raw_input = input_file.read
input_file.close
input_array = raw_input.split("\n").map(&:to_i)

result = 0

(1...input_array.size).each do |index|
  result += 1 if input_array[index] > input_array[index - 1]
end

puts result
