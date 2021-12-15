# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def parse_input(input)
    dots_input, folds_input = input.split("\n\n")

    dots = dots_input.split("\n").map do |line|
      line.split(',').map!(&:to_i)
    end

    folds = folds_input.split("\n").map do |line|
      line.gsub('fold along ', '').split('=').map! do |elem|
        if %w[x y].include?(elem)
          elem
        else
          elem.to_i
        end
      end
    end

    [dots, folds]
  end

  def horizontal_fold(paper, y)
    col_start = y + 1
    col_end = paper.first.length - 1

    paper.length.times do |row|
      current_row = paper[row]

      col_start.upto(col_end) do |col|
        current_row[2 * y - col] ||= current_row[col]
        current_row[col] = false
      end
    end
  end

  def vertical_fold(paper, x)
    row_start = x + 1
    row_end = paper.length - 1

    paper.first.length.times do |col|
      row_start.upto(row_end) do |row|
        current_row = paper[row]

        paper[2 * x - row][col] ||= current_row[col]
        current_row[col] = false
      end
    end
  end

  def main
    dots, folds = parse_input(self.class.read_input_file)

    rows = dots.reduce(0) { |max, (row, _)| max > row ? max : row } + 1
    cols = dots.reduce(0) { |max, (_, col)| max > col ? max : col } + 1

    paper = []
    rows.times { paper.append([false] * cols) }
    dots.each { |(row, col)| paper[row][col] = true }

    folds.each do |fold|
      axis = fold.first
      value = fold.last

      if axis == 'x'
        vertical_fold(paper, value)
      else
        horizontal_fold(paper, value)
      end
    end

    paper.to_s
  end
end

puts Answer.new.main
