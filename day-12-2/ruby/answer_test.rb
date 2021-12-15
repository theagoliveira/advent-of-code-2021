# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE1 = "start-A\n" \
             "start-b\n" \
             "A-c\n" \
             "A-b\n" \
             "b-d\n" \
             "A-end\n" \
             'b-end'

  EXAMPLE2 = "dc-end\n" \
             "HN-start\n" \
             "start-kj\n" \
             "dc-start\n" \
             "dc-HN\n" \
             "LN-dc\n" \
             "HN-end\n" \
             "kj-sa\n" \
             "kj-HN\n" \
             'kj-dc'

  EXAMPLE3 = "fs-end\n" \
             "he-DX\n" \
             "fs-he\n" \
             "start-DX\n" \
             "pj-DX\n" \
             "end-zg\n" \
             "zg-sl\n" \
             "zg-pj\n" \
             "pj-he\n" \
             "RW-he\n" \
             "fs-DX\n" \
             "pj-RW\n" \
             "zg-RW\n" \
             "start-pj\n" \
             "he-WI\n" \
             "zg-he\n" \
             "pj-fs\n" \
             'start-RW'

  def test_main1
    # skip
    Answer.stub(:read_input_file, EXAMPLE1) do
      assert_equal 36, Answer.new.main
    end
  end

  def test_main2
    # skip
    Answer.stub(:read_input_file, EXAMPLE2) do
      assert_equal 103, Answer.new.main
    end
  end

  def test_main3
    # skip
    Answer.stub(:read_input_file, EXAMPLE3) do
      assert_equal 3509, Answer.new.main
    end
  end
end
