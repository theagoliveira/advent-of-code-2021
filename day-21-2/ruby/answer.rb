# frozen_string_literal: true

class Answer
  QUANTUM_ROLLS = {
    3 => 1,
    4 => 3,
    5 => 6,
    6 => 7,
    7 => 6,
    8 => 3,
    9 => 1
  }.freeze

  def self.read_input_file
    File.read('input.txt')
  end

  def parse_input(input)
    input.split("\n").map { |line| line.gsub(/Player [1-2] starting position: /, '').to_i }
  end

  def move(current, rolls)
    new_pos = current + rolls
    new_pos > 10 ? new_pos - 10 : new_pos
  end

  def play(p1_pos, p2_pos, p1_score, p2_score, qty, wins)
    # puts "play(p1_pos: #{p1_pos}, p2_pos: #{p2_pos}, p1_score: #{p1_score}, p2_score: #{p2_score}, wins: #{wins})"
    # puts "wins: #{wins}"
    QUANTUM_ROLLS.each do |p1_rolls, p1_quantity|
      next_p1_pos = move(p1_pos, p1_rolls)
      next_p1_score = p1_score + next_p1_pos
      p1_qty = p1_quantity * qty

      if next_p1_score >= 21
        wins[:p1] += p1_qty
        next
      else
        QUANTUM_ROLLS.each do |p2_rolls, p2_quantity|
          next_p2_pos = move(p2_pos, p2_rolls)
          next_p2_score = p2_score + next_p2_pos
          p2_qty = p2_quantity * p1_qty

          if next_p2_score >= 21
            wins[:p2] += p2_qty
            next
          else
            play(next_p1_pos, next_p2_pos, next_p1_score, next_p2_score, p2_qty, wins)
          end
        end
      end
    end
  end

  def main
    p1_pos, p2_pos = parse_input(self.class.read_input_file)

    wins = { p1: 0, p2: 0 }

    play(p1_pos, p2_pos, 0, 0, 1, wins)

    wins.values.max
  end
end

puts Answer.new.main
