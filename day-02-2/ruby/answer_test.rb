# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE = "forward 5\n" \
            "down 5\n"    \
            "forward 8\n" \
            "up 3\n"      \
            "down 8\n"    \
            'forward 2'

  def test_main
    Answer.stub(:read_input_file, EXAMPLE) do
      assert_equal 900, Answer.new.main
    end
  end
end
