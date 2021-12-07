# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE = '16,1,2,0,4,2,7,1,2,14'

  def test_main
    # skip
    Answer.stub(:read_input_file, EXAMPLE) do
      assert_equal 168, Answer.new.main
    end
  end
end
