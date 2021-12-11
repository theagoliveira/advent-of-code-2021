# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE = "5483143223\n" \
            "2745854711\n" \
            "5264556173\n" \
            "6141336146\n" \
            "6357385478\n" \
            "4167524645\n" \
            "2176841721\n" \
            "6882881134\n" \
            "4846848554\n" \
            '5283751526'

  def test_parse_input
    skip
    assert_equal [[1, 1, 1],
                  [2, 2, 2],
                  [3, 3, 3]], Answer.new.parse_input("111\n222\n333")
  end

  def test_increment
    skip
    matrix = [[0, 0, 0], [1, 1, 1], [2, 2, 2]]
    Answer.new.increment(matrix)

    assert_equal [[1, 1, 1], [2, 2, 2], [3, 3, 3]], matrix
  end

  def test_main
    # skip
    Answer.stub(:read_input_file, EXAMPLE) do
      assert_equal 1656, Answer.new.main
    end
  end
end
