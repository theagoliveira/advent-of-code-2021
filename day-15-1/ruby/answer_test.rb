# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE = "1163751742\n" \
            "1381373672\n" \
            "2136511328\n" \
            "3694931569\n" \
            "7463417111\n" \
            "1319128137\n" \
            "1359912421\n" \
            "3125421639\n" \
            "1293138521\n" \
            '2311944581'

  PARSED_EXAMPLE = [
    [1, 1, 6, 3, 7, 5, 1, 7, 4, 2],
    [1, 3, 8, 1, 3, 7, 3, 6, 7, 2],
    [2, 1, 3, 6, 5, 1, 1, 3, 2, 8],
    [3, 6, 9, 4, 9, 3, 1, 5, 6, 9],
    [7, 4, 6, 3, 4, 1, 7, 1, 1, 1],
    [1, 3, 1, 9, 1, 2, 8, 1, 3, 7],
    [1, 3, 5, 9, 9, 1, 2, 4, 2, 1],
    [3, 1, 2, 5, 4, 2, 1, 6, 3, 9],
    [1, 2, 9, 3, 1, 3, 8, 5, 2, 1],
    [2, 3, 1, 1, 9, 4, 4, 5, 8, 1]
  ].freeze

  def test_parse_input
    skip
    assert_equal PARSED_EXAMPLE, Answer.new.parse_input(EXAMPLE)
  end

  def test_main
    # skip
    Answer.stub(:read_input_file, EXAMPLE) do
      assert_equal 40, Answer.new.main
    end
  end
end
