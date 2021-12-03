# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def count_ones(data, index)
    data.reduce(0) { |count, number| count + number[index].to_i }
  end

  def most_common(data, index)
    count_ones(data, index) > data.size / 2.0 ? 1 : 0
  end

  def main
    diagnostic_report = self.class.read_input_file.split("\n")
    number_size = diagnostic_report.first.size

    gamma_rate = (0...number_size).reduce(0) do |rate, index|
      (rate << 1) + most_common(diagnostic_report, index)
    end
    epsilon_rate = gamma_rate ^ (2**number_size - 1)

    power_consumption = gamma_rate * epsilon_rate
    power_consumption
  end
end

puts Answer.new.main
