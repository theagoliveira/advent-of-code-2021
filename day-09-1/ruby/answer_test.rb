# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE = "2199943210\n" \
            "3987894921\n" \
            "9856789892\n" \
            "8767896789\n" \
            '9899965678'

  def test_main
    # skip
    Answer.stub(:read_input_file, EXAMPLE) do
      assert_equal 15, Answer.new.main
    end
  end
end
