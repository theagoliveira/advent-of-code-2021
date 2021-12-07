# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def main
    crab_positions = self.class.read_input_file.split(',').map(&:to_i)
    positions_count_hash = Hash.new(0)
    crab_positions.each { |position| positions_count_hash[position] += 1 }

    min_fuel = -1
    beginning = positions_count_hash.keys.min
    ending = positions_count_hash.keys.max

    beginning.upto(ending) do |position|
      current_fuel = calculate_fuel(positions_count_hash, position)
      min_fuel = current_fuel if current_fuel < min_fuel || min_fuel.negative?
    end

    min_fuel
  end

  def calculate_fuel(positions_count_hash, target_position)
    positions_count_hash.reduce(0) do |fuel, (position, count)|
      fuel + accumulate((position - target_position).abs) * count
    end
  end

  def accumulate(number)
    number * (number + 1) / 2
  end
end

puts Answer.new.main
