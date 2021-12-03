# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def count_ones(data, index)
    data.reduce(0) { |count, number| count + number[index].to_i }
  end

  def most_common(data, index)
    count_ones(data, index) >= data.size / 2.0 ? '1' : '0'
  end

  def least_common(data, index)
    count_ones(data, index) >= data.size / 2.0 ? '0' : '1'
  end

  def filter_candidates(data, function)
    index = 0

    while data.size > 1
      target = send(function, data, index)
      data.select! { |number| number[index] == target }
      index += 1
    end
  end

  def main
    diagnostic_report = self.class.read_input_file.split("\n")

    oxygen_candidates = diagnostic_report.dup
    co2_candidates = diagnostic_report.dup

    filter_candidates(oxygen_candidates, 'most_common')
    filter_candidates(co2_candidates, 'least_common')

    oxygen_generator_rating = oxygen_candidates.first.to_i(2)
    co2_scrubber_rating = co2_candidates.first.to_i(2)

    life_support_rating = oxygen_generator_rating * co2_scrubber_rating
    life_support_rating
  end
end

puts Answer.new.main
