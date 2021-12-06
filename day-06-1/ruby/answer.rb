# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def main
    current_state = self.class.read_input_file.split(',').map(&:to_i)
    days = 0
    zero_count = 0

    while days < 80
      zero_count += current_state.count(0)
      current_state.map! do |timer|
        timer == 8 ? timer - 1 : (timer - 1) % 7
      end

      zero_count.times do
        current_state.append(8)
      end

      days += 1
      zero_count = 0
    end

    current_state.size
  end
end

# puts Answer.new.main
