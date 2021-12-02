# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  def test_main
    assert_equal Answer.main, ''
  end

  def test_read_input_file
    assert_equal Answer.read_input_file, ''
  end

  def test_split_data
    assert_equal Answer.split_data("1\n2\n3", "\n"), %w[1 2 3]
  end

  def test_split_and_convert_to_int
    assert_equal Answer.split_and_convert_to_int("1\n2\n3", "\n"), [1, 2, 3]
  end
end
