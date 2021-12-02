# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def main
    commands = self.class.read_input_file.split("\n")

    aim = depth = horizontal = 0

    commands.each do |command|
      word, number = command.split(' ')
      number = number.to_i

      if word == 'forward'
        horizontal += number
        depth += aim * number
      end

      aim += number if word == 'down'
      aim -= number if word == 'up'
    end

    depth * horizontal
  end
end

puts Answer.new.main
