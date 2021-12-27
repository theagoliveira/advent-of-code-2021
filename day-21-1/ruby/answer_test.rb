# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE = "Player 1 starting position: 4\n" \
            'Player 2 starting position: 8'
  PARSED_EXAMPLE = [4, 8].freeze

  def test_parse_input
    skip
    assert_equal PARSED_EXAMPLE, Answer.new.parse_input(EXAMPLE)
  end

  def test_main
    # skip
    Answer.stub(:read_input_file, EXAMPLE) do
      assert_equal 739_785, Answer.new.main
    end
  end
end
