# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def main
    entries = self.class.read_input_file.split("\n").map do |entry|
      entry.split(' | ')
    end

    unique_signal_patterns = []
    four_digit_output_values = []

    entries.each do |entry|
      unique_signal_patterns.append(entry.first.split)
      four_digit_output_values.append(entry.last.split)
    end

    result = 0

    unique_signal_patterns.each_with_index do |patterns, index|
      patterns_map = {}
      pattern_1 = nil
      pattern_4 = nil

      patterns.each do |pattern|
        next unless [2, 3, 4, 7].include? pattern.size

        sorted_pattern_chars = pattern.chars.sort

        if pattern.size == 2
          patterns_map[sorted_pattern_chars] = 1
          pattern_1 = sorted_pattern_chars
        elsif pattern.size == 3
          patterns_map[sorted_pattern_chars] = 7
        elsif pattern.size == 7
          patterns_map[sorted_pattern_chars] = 8
        else
          patterns_map[sorted_pattern_chars] = 4
          pattern_4 = sorted_pattern_chars
        end
      end

      patterns.each do |pattern|
        next unless [5, 6].include? pattern.size

        sorted_pattern_chars = pattern.chars.sort
        intersection_with_1_size = (sorted_pattern_chars & pattern_1).size
        intersection_with_4_size = (sorted_pattern_chars & pattern_4).size

        if intersection_with_4_size == 2
          patterns_map[sorted_pattern_chars] = 2
        elsif intersection_with_4_size == 4
          patterns_map[sorted_pattern_chars] = 9
        else
          if intersection_with_1_size == 2
            if pattern.size == 5
              patterns_map[sorted_pattern_chars] = 3
            else
              patterns_map[sorted_pattern_chars] = 0
            end
          else
            patterns_map[sorted_pattern_chars] = pattern.size
          end
        end
      end

      result += four_digit_output_values[index].map do |value|
        patterns_map[value.chars.sort]
      end.join.to_i
    end

    result
  end
end

puts Answer.new.main
