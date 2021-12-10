# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE = "[({(<(())[]>[[{[]{<()<>>\n" \
            "[(()[<>])]({[<{<<[]>>(\n" \
            "{([(<{}[<>[]}>{[]{[(<()>\n" \
            "(((({<>}<{<{<>}{[]{[]{}\n" \
            "[[<[([]))<([[{}[[()]]]\n" \
            "[{[{({}]{}}([{[{{{}}([]\n" \
            "{<[[]]>}<{[{[{[]{()[[[]\n" \
            "[<(<(<(<{}))><([]([]()\n" \
            "<{([([[(<>()){}]>(<<{{\n" \
            '<{([{{}}[<[[[<>{}]]]>[]]'

  def test_main
    # skip
    Answer.stub(:read_input_file, EXAMPLE) do
      assert_equal 288_957, Answer.new.main
    end
  end
end
