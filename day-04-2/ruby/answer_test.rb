# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE = "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1\n\n" \
            "22 13 17 11  0\n" \
            "8  2 23  4 24\n" \
            "21  9 14 16  7\n" \
            "6 10  3 18  5\n" \
            "1 12 20 15 19\n\n" \
            "3 15  0  2 22\n" \
            "9 18 13 17  5\n" \
            "19  8  7 25 23\n" \
            "20 11 10 24  4\n" \
            "14 21 16 12  6\n\n" \
            "14 21 17 24  4\n" \
            "10 16 15  9 19\n" \
            "18  8 23 26 20\n" \
            "22 11 13  6  5\n" \
            '2  0 12  3  7'

  BOARDS = [[%w[22 13 17 11 0],
             %w[8 2 23 4 24],
             %w[21 9 14 16 7],
             %w[6 10 3 18 5],
             %w[1 12 20 15 19]],
            [%w[3 15 0 2 22],
             %w[9 18 13 17 5],
             %w[19 8 7 25 23],
             %w[20 11 10 24 4],
             %w[14 21 16 12 6]],
            [%w[14 21 17 24 4],
             %w[10 16 15 9 19],
             %w[18 8 23 26 20],
             %w[22 11 13 6 5],
             %w[2 0 12 3 7]]].freeze

  MARKED_BOARD = [%w[X 13 17 11 0],
                  %w[8 2 23 4 24],
                  %w[21 9 14 16 7],
                  %w[6 10 3 18 5],
                  %w[1 12 20 15 19]].freeze

  WINNING_BOARD_ROW = [%w[22 13 17 11 0],
                       %w[8 2 23 4 24],
                       %w[X X X X X],
                       %w[6 10 3 18 5],
                       %w[1 12 20 15 19]].freeze

  WINNING_BOARD_COLUMN = [%w[22 13 X 11 0],
                          %w[8 2 X 4 24],
                          %w[21 9 X 16 7],
                          %w[6 10 X 18 5],
                          %w[1 12 X 15 19]].freeze

  def test_get_boards
    skip
    data = EXAMPLE.dup.split("\n")
    data.shift(2)

    assert_equal BOARDS.dup, Answer.new.get_boards(data, data.first.split.size)
  end

  def test_mark_board
    skip
    board = BOARDS[0].dup
    Answer.new.mark_board(board, '22')

    assert_equal MARKED_BOARD.dup, board
  end

  def test_check_false
    skip
    assert_equal false, Answer.new.check(MARKED_BOARD)
  end

  def test_check_true_row
    skip
    assert_equal true, Answer.new.check(WINNING_BOARD_ROW)
  end

  def test_check_true_column
    skip
    assert_equal true, Answer.new.check(WINNING_BOARD_COLUMN)
  end

  def test_main
    # skip
    Answer.stub(:read_input_file, EXAMPLE) do
      assert_equal 1924, Answer.new.main
    end
  end
end
