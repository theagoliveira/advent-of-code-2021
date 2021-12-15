# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE = ''
  PARSED_EXAMPLE = ''

  def test_parse_input
    skip
    assert_equal PARSED_EXAMPLE, Answer.new.parse_input(EXAMPLE)
  end

  def test_main
    # skip
    Answer.stub(:read_input_file, EXAMPLE) do
      assert_equal 0, Answer.new.main
    end
  end
end
