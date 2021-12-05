# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE = "0,9 -> 5,9\n" \
            "8,0 -> 0,8\n" \
            "9,4 -> 3,4\n" \
            "2,2 -> 2,1\n" \
            "7,0 -> 7,4\n" \
            "6,4 -> 2,0\n" \
            "0,9 -> 2,9\n" \
            "3,4 -> 1,4\n" \
            "0,0 -> 8,8\n" \
            '5,5 -> 8,2'

  READINGS = [
    [[0, 9], [5, 9]],
    [[8, 0], [0, 8]],
    [[9, 4], [3, 4]],
    [[2, 2], [2, 1]],
    [[7, 0], [7, 4]],
    [[6, 4], [2, 0]],
    [[0, 9], [2, 9]],
    [[3, 4], [1, 4]],
    [[0, 0], [8, 8]],
    [[5, 5], [8, 2]]
  ]

  INITIAL_DIAGRAM = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  ]

  DRAW_HORIZONTAL_DIAGRAM = [ # 0,9 -> 5,9
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [1, 1, 1, 1, 1, 1, 0, 0, 0, 0]
  ]

  DRAW_VERTICAL_DIAGRAM = [ # 2,2 -> 2,1
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 1, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 1, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  ]


  DRAW_DIAGONAL_DIAGRAM = [ # 8,0 -> 0,8
    [0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
    [0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
    [0, 0, 0, 0, 0, 0, 1, 0, 0, 0],
    [0, 0, 0, 0, 0, 1, 0, 0, 0, 0],
    [0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
    [0, 0, 1, 0, 0, 0, 0, 0, 0, 0],
    [0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  ]

  END_DIAGRAM = [
    [1, 0, 1, 0, 0, 0, 0, 1, 1, 0],
    [0, 1, 1, 1, 0, 0, 0, 2, 0, 0],
    [0, 0, 2, 0, 1, 0, 1, 1, 1, 0],
    [0, 0, 0, 1, 0, 2, 0, 2, 0, 0],
    [0, 1, 1, 2, 3, 1, 3, 2, 1, 1],
    [0, 0, 0, 1, 0, 2, 0, 0, 0, 0],
    [0, 0, 1, 0, 0, 0, 1, 0, 0, 0],
    [0, 1, 0, 0, 0, 0, 0, 1, 0, 0],
    [1, 0, 0, 0, 0, 0, 0, 0, 1, 0],
    [2, 2, 2, 1, 1, 1, 0, 0, 0, 0]
  ]

  def test_get_readings
    skip
    data = EXAMPLE.dup.split("\n")

    assert_equal READINGS.dup, Answer.new.get_readings(data)
  end

  def test_generate_diagram
    skip
    readings = READINGS.dup

    assert_equal INITIAL_DIAGRAM.dup, Answer.new.generate_diagram(readings)
  end

  def test_draw_horizontal
    skip
    diagram = INITIAL_DIAGRAM.dup
    Answer.new.draw_horizontal(diagram, 9, 0, 5)

    assert_equal DRAW_HORIZONTAL_DIAGRAM.dup, diagram
  end

  def test_draw_vertical
    skip
    diagram = INITIAL_DIAGRAM.dup
    Answer.new.draw_vertical(diagram, 2, 1, 2)

    assert_equal DRAW_VERTICAL_DIAGRAM.dup, diagram
  end

  def test_draw_diagonal
    skip
    diagram = INITIAL_DIAGRAM.dup
    Answer.new.draw_diagonal(diagram, 0, 8, 8, 0)

    assert_equal DRAW_DIAGONAL_DIAGRAM.dup, diagram
  end

  def test_main
    # skip
    Answer.stub(:read_input_file, EXAMPLE) do
      assert_equal 12, Answer.new.main
    end
  end
end
