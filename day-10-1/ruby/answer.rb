# frozen_string_literal: true

class Answer
  BRACKET_SCORES = {
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25_137
  }.freeze

  BRACKET_PAIRS = {
    ')' => '(',
    ']' => '[',
    '}' => '{',
    '>' => '<'
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

    illegal = Hash.new(0)

    chunk_lines.each do |line|
      bracket_stack = []

      line.chars.each do |bracket|
        if opening?(bracket)
          bracket_stack.push(bracket)
        elsif bracket_stack.size.zero? || bracket_stack.last != BRACKET_PAIRS[bracket]
          illegal[bracket] += 1
          break
        else
          bracket_stack.pop
        end
      end
    end

    illegal.map { |bracket, count| count * BRACKET_SCORES[bracket] }.sum
  end
end

puts Answer.new.main
