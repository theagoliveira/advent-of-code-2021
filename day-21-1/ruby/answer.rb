# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def parse_input(input)
    input.split("\n").map { |line| line.gsub(/Player [1-2] starting position: /, '').to_i }
  end

  def roll(current)
    current == 100 ? 1 : current + 1
  end

  def move(current, rolls)
    rolls %= 10
    new_pos = current + rolls

    new_pos > 10 ? new_pos - 10 : new_pos
  end

  def turn(pos, dice)
    turn_rolls = 0

    3.times do
      dice = roll(dice)
      turn_rolls += dice
    end

    [move(pos, turn_rolls), dice]
  end

  def main
    p1_pos, p2_pos = parse_input(self.class.read_input_file)
    dice = 0
    rolls = 0
    p1_score = 0
    p2_score = 0

    while p1_score < 1000 && p2_score < 1000
      p1_pos, dice = turn(p1_pos, dice)
      p1_score += p1_pos
      rolls += 3

      break if p1_score >= 1000

      p2_pos, dice = turn(p2_pos, dice)
      p2_score += p2_pos
      rolls += 3
    end

    rolls * [p1_score, p2_score].min
  end
end

puts Answer.new.main
