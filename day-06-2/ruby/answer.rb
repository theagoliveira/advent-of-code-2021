# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def main
    current_state = self.class.read_input_file.split(',').map(&:to_i)
    current_zeros = 0

    count_hash = {}
    0.upto(8) { |number| count_hash[number] = 0 }

    current_state.each do |timer|
      count_hash[timer] += 1
    end

    256.times do
      count_hash.keys.sort.each do |timer|
        if timer.zero?
          current_zeros = count_hash[timer]
          next
        end

        next if count_hash[timer].zero?

        count_hash[timer - 1] += count_hash[timer]
        count_hash[timer] = 0
      end

      count_hash[0] -= current_zeros
      count_hash[6] += current_zeros
      count_hash[8] += current_zeros
    end

    count_hash.values.sum
  end
end

puts Answer.new.main
