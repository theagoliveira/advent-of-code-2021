# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE1 = "on x=10..12,y=10..12,z=10..12\n" \
            "on x=11..13,y=11..13,z=11..13\n" \
            "off x=9..11,y=9..11,z=9..11\n" \
            'on x=10..10,y=10..10,z=10..10'
  PARSED_EXAMPLE1 = [
    [true, [10..12, 10..12, 10..12]],
    [true, [11..13, 11..13, 11..13]],
    [false, [9..11, 9..11, 9..11]],
    [true, [10..10, 10..10, 10..10]]
  ].freeze

  EXAMPLE2 = "on x=-20..26,y=-36..17,z=-47..7\n" \
             "on x=-20..33,y=-1..23,z=-26..28\n" \
             "on x=-22..28,y=-29..23,z=-38..16\n" \
             "on x=-46..7,y=-6..46,z=-50..-1\n" \
             "on x=-49..1,y=-3..46,z=-24..28\n" \
             "on x=2..47,y=-22..22,z=-23..27\n" \
             "on x=-27..23,y=-28..26,z=-21..29\n" \
             "on x=-39..5,y=-6..47,z=-3..44\n" \
             "on x=-30..21,y=-8..43,z=-13..34\n" \
             "on x=-22..26,y=-27..20,z=-29..19\n" \
             "off x=-48..-32,y=26..41,z=-47..-37\n" \
             "on x=-12..35,y=6..50,z=-50..-2\n" \
             "off x=-48..-32,y=-32..-16,z=-15..-5\n" \
             "on x=-18..26,y=-33..15,z=-7..46\n" \
             "off x=-40..-22,y=-38..-28,z=23..41\n" \
             "on x=-16..35,y=-41..10,z=-47..6\n" \
             "off x=-32..-23,y=11..30,z=-14..3\n" \
             "on x=-49..-5,y=-3..45,z=-29..18\n" \
             "off x=18..30,y=-20..-8,z=-3..13\n" \
             "on x=-41..9,y=-7..43,z=-33..15\n" \
             "on x=-54112..-39298,y=-85059..-49293,z=-27449..7877\n" \
             'on x=967..23432,y=45373..81175,z=27513..53682'

  def test_parse_input
    skip
    assert_equal PARSED_EXAMPLE1, Answer.new.parse_input(EXAMPLE1)
  end

  def test_main1
    # skip
    Answer.stub(:read_input_file, EXAMPLE1) do
      assert_equal 39, Answer.new.main
    end
  end

  # This test fails, but the answer is right - wtf
  def test_main2
    # skip
    Answer.stub(:read_input_file, EXAMPLE2) do
      assert_equal 590_784, Answer.new.main
    end
  end
end
