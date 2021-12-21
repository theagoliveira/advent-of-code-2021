# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE = 'target area: x=20..30, y=-10..-5'
  PARSED_EXAMPLE = [20, 30, -10, -5].freeze

  def test_parse_input
    skip
    assert_equal PARSED_EXAMPLE, Answer.new.parse_input(EXAMPLE)
  end

  def test_main
    # skip
    Answer.stub(:read_input_file, EXAMPLE) do
      assert_equal 45, Answer.new.main
    end
  end
end
