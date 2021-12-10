# frozen_string_literal: true

class Answer
  BRACKET_SCORES = {
    ')' => 1,
    ']' => 2,
    '}' => 3,
    '>' => 4
  }.freeze

  CLOSING_BRACKET_PAIRS = {
    ')' => '(',
    ']' => '[',
    '}' => '{',
    '>' => '<'
  }.freeze

  OPENING_BRACKET_PAIRS = {
    '(' => ')',
    '[' => ']',
    '{' => '}',
    '<' => '>'
  }.freeze

  def opening?(char)
    ['(', '[', '{', '<'].include?(char)
  end

  def closing?(char)
    [')', ']', '}', '>'].include?(char)
  end

  def self.read_input_file
    File.read('input.txt')
  end

  def main
    chunk_lines = self.class.read_input_file.split("\n")

    scores = []

    chunk_lines.each do |line|
      bracket_stack = []
      illegal = false
      total = 0

      line.chars.each do |bracket|
        if opening?(bracket)
          bracket_stack.push(bracket)
        elsif bracket_stack.size.zero? || bracket_stack.last != CLOSING_BRACKET_PAIRS[bracket]
          illegal = true
          break
        else
          bracket_stack.pop
        end
      end

      next if illegal

      while bracket_stack.size.positive?
        total *= 5
        total += BRACKET_SCORES[OPENING_BRACKET_PAIRS[bracket_stack.pop]]
      end

      scores.append(total)
    end

    scores.sort[scores.size / 2]
  end
end

puts Answer.new.main
