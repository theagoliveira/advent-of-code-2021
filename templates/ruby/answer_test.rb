# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE = ''

  def test_main
    Answer.stub(:read_input_file, EXAMPLE) do
      assert_equal Answer.new.main, 0
    end
  end
end
