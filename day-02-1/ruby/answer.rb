# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def main
    commands = self.class.read_input_file.split("\n")

    depth = horizontal = 0

    commands.each do |command|
      word, number = command.split(' ')
      number = number.to_i

      depth += number if word == 'down'
      depth -= number if word == 'up'
      horizontal += number if word == 'forward'
    end

    depth * horizontal
  end
end

puts Answer.new.main
