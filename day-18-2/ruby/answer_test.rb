# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE1 = "[[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]\n" \
            "[[[5,[2,8]],4],[5,[[9,9],0]]]\n" \
            "[6,[[[6,2],[5,6]],[[7,6],[4,7]]]]\n" \
            "[[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]\n" \
            "[[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]\n" \
            "[[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]\n" \
            "[[[[5,4],[7,7]],8],[[8,3],8]]\n" \
            "[[9,3],[[9,9],[6,[4,9]]]]\n" \
            "[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]\n" \
            '[[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]'

  PARSED_EXAMPLE1 = [
    [[[0, [5, 8]], [[1, 7], [9, 6]]], [[4, [1, 2]], [[1, 4], 2]]],
    [[[5, [2, 8]], 4], [5, [[9, 9], 0]]],
    [6, [[[6, 2], [5, 6]], [[7, 6], [4, 7]]]],
    [[[6, [0, 7]], [0, 9]], [4, [9, [9, 0]]]],
    [[[7, [6, 4]], [3, [1, 3]]], [[[5, 5], 1], 9]],
    [[6, [[7, 3], [3, 2]]], [[[3, 8], [5, 7]], 4]],
    [[[[5, 4], [7, 7]], 8], [[8, 3], 8]],
    [[9, 3], [[9, 9], [6, [4, 9]]]],
    [[2, [[7, 7], 7]], [[5, 8], [[9, 3], [0, 2]]]],
    [[[[5, 2], 5], [8, [3, 7]]], [[5, [7, 5]], [4, 4]]]
  ]

  PARSED_EXAMPLE2 = [[1, 1], [2, 2], [3, 3], [4, 4]].freeze
  PARSED_EXAMPLE3 = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5]].freeze
  PARSED_EXAMPLE4 = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6]].freeze
  PARSED_EXAMPLE5 = [
    [[[0, [4, 5]], [0, 0]], [[[4, 5], [2, 6]], [9, 5]]],
    [7, [[[3, 7], [4, 3]], [[6, 3], [8, 8]]]],
    [[2, [[0, 8], [3, 4]]], [[[6, 7], 1], [7, [1, 6]]]],
    [[[[2, 4], 7], [6, [0, 5]]], [[[6, 8], [2, 8]], [[2, 1], [4, 5]]]],
    [7, [5, [[3, 8], [1, 4]]]],
    [[2, [2, 2]], [8, [8, 1]]],
    [2, 9],
    [1, [[[9, 3], 9], [[9, 0], [0, 7]]]],
    [[[5, [7, 4]], 7], 1],
    [[[[4, 2], 2], 6], [8, 7]]
  ].freeze

  ADD_TEST = [
    [[[[7, 0], [7, 7]], [[7, 7], [7, 8]]], [[[7, 7], [8, 8]], [[7, 7], [8, 7]]]],
    [7, [5, [[3, 8], [1, 4]]]]
  ].freeze

  def test_parse_input
    skip
    assert_equal PARSED_EXAMPLE1, Answer.new.parse_input(EXAMPLE1)
  end

  def test_magnitude
    skip
    assert_equal 143, Answer.new.magnitude([[1, 2], [[3, 4], 5]])
    assert_equal 1384, Answer.new.magnitude([[[[0, 7], 4], [[7, 8], [6, 0]]], [8, 1]])
    assert_equal 445, Answer.new.magnitude([[[[1, 1], [2, 2]], [3, 3]], [4, 4]])
    assert_equal 791, Answer.new.magnitude([[[[3, 0], [5, 3]], [4, 4]], [5, 5]])
    assert_equal 1137, Answer.new.magnitude([[[[5, 0], [7, 4]], [5, 5]], [6, 6]])
    assert_equal 3488, Answer.new.magnitude([[[[8, 7], [7, 7]], [[8, 6], [7, 7]]], [[[0, 7], [6, 6]], [8, 7]]])
  end

  def test_pair
    skip
    assert_equal true, Answer.new.pair?([1, 2])
    assert_equal false, Answer.new.pair?([1, [2, 3]])
    assert_equal false, Answer.new.pair?([[1, 2], 3])
    assert_equal false, Answer.new.pair?([[1, 2], [3, 4]])
  end

  def test_add
    skip
    assert_equal [[1, 2], [3, 4]], Answer.new.add([1, 2], [3, 4])
  end

  # def test_reduce
  #   skip
  #   number = [[[[[4, 3], 4], 4], [7, [[8, 4], 9]]], [1, 1]]
  #   ans = Answer.new
  #   ans.reduce(number, 0, [0, 0], 1, [0, 0], 0, false, number) while ans.reduce_actions_apply(number, 0)

  #   assert_equal [[[[0, 7], 4], [[7, 8], [6, 0]]], [8, 1]], number
  # end

  # def test_reduce2
  #   skip
  #   x = [[[0, [4, 5]], [0, 0]], [[[4, 5], [2, 6]], [9, 5]]]
  #   y = [7, [[[3, 7], [4, 3]], [[6, 3], [8, 8]]]]
  #   ans = Answer.new
  #   number = ans.add(x, y)
  #   ans.reduce(number, 0, [0, 0], 1, [0, 0], 0, [false], number) while ans.reduce_actions_apply(number, 0)

  #   assert_equal [[[[4, 0], [5, 4]], [[7, 7], [6, 0]]], [[8, [7, 7]], [[7, 9], [5, 0]]]], number
  # end

  def test_add_all
    skip
    ans = Answer.new

    assert_equal [[[[1, 1], [2, 2]], [3, 3]], [4, 4]], ans.add_all(PARSED_EXAMPLE2.dup)
    assert_equal [[[[3, 0], [5, 3]], [4, 4]], [5, 5]], ans.add_all(PARSED_EXAMPLE3.dup)
    assert_equal [[[[5, 0], [7, 4]], [5, 5]], [6, 6]], ans.add_all(PARSED_EXAMPLE4.dup)
    assert_equal [[[[8, 7], [7, 7]], [[8, 6], [7, 7]]], [[[0, 7], [6, 6]], [8, 7]]], ans.add_all(PARSED_EXAMPLE5.dup)
    assert_equal [[[[7, 7], [7, 8]], [[9, 5], [8, 7]]], [[[6, 8], [0, 8]], [[9, 9], [9, 0]]]], ans.add_all(ADD_TEST.dup)
  end

  def test_reduce_actions_apply
    skip
    assert_equal true, Answer.new.reduce_actions_apply([[[[[4, 3], 4], 4], [7, [[8, 4], 9]]], [1, 1]], 0)
    assert_equal true, Answer.new.reduce_actions_apply([[[[0, 7], 4], [7, [[8, 4], 9]]], [1, 1]], 0)
    assert_equal true, Answer.new.reduce_actions_apply([[[[0, 7], 4], [15, [0, 13]]], [1, 1]], 0)
    assert_equal true, Answer.new.reduce_actions_apply([[[[0, 7], 4], [[7, 8], [0, 13]]], [1, 1]], 0)
    assert_equal true, Answer.new.reduce_actions_apply([[[[0, 7], 4], [[7, 8], [0, [6, 7]]]], [1, 1]], 0)
    assert_equal false, Answer.new.reduce_actions_apply([[[[0, 7], 4], [[7, 8], [6, 0]]], [8, 1]], 0)
  end

  def test_split
    skip
    assert_equal [5, 5], Answer.new.split(10)
    assert_equal [5, 6], Answer.new.split(11)
    assert_equal [6, 6], Answer.new.split(12)
  end

  def test_main
    # skip
    Answer.stub(:read_input_file, EXAMPLE1) do
      assert_equal 3993, Answer.new.main
    end
  end
end
