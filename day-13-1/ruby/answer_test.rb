# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE = "6,10\n" \
            "0,14\n" \
            "9,10\n" \
            "0,3\n" \
            "10,4\n" \
            "4,11\n" \
            "6,0\n" \
            "6,12\n" \
            "4,1\n" \
            "0,13\n" \
            "10,12\n" \
            "3,4\n" \
            "3,0\n" \
            "8,4\n" \
            "1,10\n" \
            "2,14\n" \
            "8,10\n" \
            "9,0\n\n" \
            "fold along y=7\n" \
            'fold along x=5'

  PARSED_EXAMPLE = [[[6, 10],
                     [0, 14],
                     [9, 10],
                     [0, 3],
                     [10, 4],
                     [4, 11],
                     [6, 0],
                     [6, 12],
                     [4, 1],
                     [0, 13],
                     [10, 12],
                     [3, 4],
                     [3, 0],
                     [8, 4],
                     [1, 10],
                     [2, 14],
                     [8, 10],
                     [9, 0]],
                    [['y', 7],
                     ['x', 5]]].freeze

  def test_parse_input
    skip
    assert_equal PARSED_EXAMPLE, Answer.new.parse_input(EXAMPLE)
  end

  def test_main
    # skip
    Answer.stub(:read_input_file, EXAMPLE) do
      assert_equal 17, Answer.new.main
    end
  end
end
