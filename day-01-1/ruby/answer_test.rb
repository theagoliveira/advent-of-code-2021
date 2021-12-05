# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE = "199\n200\n208\n210\n200\n207\n240\n269\n260\n263"

  def test_main
    # skip
    Answer.stub(:read_input_file, EXAMPLE) do
      assert_equal 7, Answer.new.main
    end
  end
end
