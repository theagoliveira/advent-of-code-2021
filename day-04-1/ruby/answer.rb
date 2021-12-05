# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def main
    data = self.class.read_input_file.split("\n")
    drawn_numbers = data.shift.split(',')

    data.shift # remove empty string after drawn numbers

    boards = get_boards(data, data.first.split.size)

    winning_board = []
    last_number = 0

    drawn_numbers.each do |drawn_number|
      boards.each do |board|
        mark_board(board, drawn_number)

        next unless check(board)

        winning_board = board
        last_number = drawn_number.to_i
        break
      end

      break if winning_board.any?
    end

    score = winning_board.reduce(0) do |board_sum, row|
      board_sum + row.reject { |number| number == 'X' }
                     .reduce(0) { |row_sum, number| row_sum + number.to_i }
    end

    final_score = score * last_number
    final_score
  end

  def get_boards(data, board_size)
    data.reject(&:empty?).map(&:split).each_slice(board_size).to_a
  end

  def mark_board(board, drawn_number)
    board.each do |row|
      row.map! { |number| number == drawn_number ? 'X' : number }
    end
  end

  def check(board)
    check_rows(board) || check_columns(board)
  end

  def check_rows(board)
    board.each do |row|
      return true if row == ['X'] * row.size
    end

    false
  end

  def check_columns(board)
    board.transpose.each do |column|
      return true if column == ['X'] * column.size
    end

    false
  end
end

puts Answer.new.main
