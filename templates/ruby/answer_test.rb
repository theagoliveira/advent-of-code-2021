# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE = ''

  def test_main
    # skip
    Answer.stub(:read_input_file, EXAMPLE) do
      assert_equal 0, Answer.new.main
    end
  end
end
