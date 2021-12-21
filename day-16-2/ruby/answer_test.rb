# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE1 = 'C200B40A82'
  EXAMPLE2 = '04005AC33890'
  EXAMPLE3 = '880086C3E88112'
  EXAMPLE4 = 'CE00C43D881120'
  EXAMPLE5 = 'D8005AC2A8F0'
  EXAMPLE6 = 'F600BC2D8F'
  EXAMPLE7 = '9C005AC2F8F0'
  EXAMPLE8 = '9C0141080250320F1802104A08'

  def test_main1
    # skip
    Answer.stub(:read_input_file, EXAMPLE1) do
      assert_equal 3, Answer.new.main
    end
  end

  def test_main2
    # skip
    Answer.stub(:read_input_file, EXAMPLE2) do
      assert_equal 54, Answer.new.main
    end
  end

  def test_main3
    # skip
    Answer.stub(:read_input_file, EXAMPLE3) do
      assert_equal 7, Answer.new.main
    end
  end

  def test_main4
    # skip
    Answer.stub(:read_input_file, EXAMPLE4) do
      assert_equal 9, Answer.new.main
    end
  end

  def test_main5
    # skip
    Answer.stub(:read_input_file, EXAMPLE5) do
      assert_equal 1, Answer.new.main
    end
  end

  def test_main6
    # skip
    Answer.stub(:read_input_file, EXAMPLE6) do
      assert_equal 0, Answer.new.main
    end
  end

  def test_main7
    # skip
    Answer.stub(:read_input_file, EXAMPLE7) do
      assert_equal 0, Answer.new.main
    end
  end

  def test_main8
    # skip
    Answer.stub(:read_input_file, EXAMPLE8) do
      assert_equal 1, Answer.new.main
    end
  end
end
