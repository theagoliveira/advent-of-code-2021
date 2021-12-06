# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE = '3,4,3,1,2'

  def test_main
    # skip
    Answer.stub(:read_input_file, EXAMPLE) do
      assert_equal 26984457539, Answer.new.main
    end
  end
end
