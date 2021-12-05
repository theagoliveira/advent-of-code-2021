# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE = "00100\n" \
            "11110\n" \
            "10110\n" \
            "10111\n" \
            "10101\n" \
            "01111\n" \
            "00111\n" \
            "11100\n" \
            "10000\n" \
            "11001\n" \
            "00010\n" \
            '01010'

  def test_main
    Answer.stub(:read_input_file, EXAMPLE) do
      assert_equal 230, Answer.new.main
    end
  end
end
