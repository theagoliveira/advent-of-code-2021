# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def parse_input(input)
    input.split("\n").map do |line|
      line.chars.map!(&:to_i)
    end
  end

  def increment(matrix)
    matrix.each { |line| line.map! { |number| number + 1 } }
  end

  def valid?(matrix, neighbor)
    row, col = neighbor

    row >= 0 && row <= matrix.length - 1 &&
      col >= 0 && col <= matrix.first.length - 1
  end

  def neighbors(matrix, row, col)
    [
      [row - 1, col + 0], # top
      [row - 1, col + 1], # top right
      [row + 0, col + 1], # right
      [row + 1, col + 1], # bottom right
      [row + 1, col + 0], # bottom
      [row + 1, col - 1], # bottom left
      [row + 0, col - 1], # left
      [row - 1, col - 1]  # top left
    ].select { |neighbor| valid?(matrix, neighbor) }
  end

  def flash(energy_levels, flashed, row, col)
    neighbors(energy_levels, row, col).each do |neighbor|
      n_row, n_col = neighbor
      energy_levels[n_row][n_col] += 1
    end

    flashed[row][col] = true

    reflash(energy_levels, flashed, row, col)
  end

  def reflash(energy_levels, flashed, row, col)
    neighbors(energy_levels, row, col).each do |neighbor|
      n_row, n_col = neighbor

      next unless energy_levels[n_row][n_col] > 9 && !flashed[n_row][n_col]

      flash(energy_levels, flashed, n_row, n_col)
      flashed[n_row][n_col] = true
      reflash(energy_levels, flashed, n_row, n_col)
    end
  end

  def false_matrix(matrix)
    false_matrix = []
    matrix.length.times { false_matrix.append([false] * matrix.first.length) }
    false_matrix
  end

  def main
    energy_levels = parse_input(self.class.read_input_file)

    flashed = false_matrix(energy_levels)
    flashes = 0

    # puts "\nBefore any steps:\n#{energy_levels.map(&:join).join("\n")}\n\n"

    100.times do |step|
      increment(energy_levels)

      0.upto(energy_levels.length - 1) do |row|
        0.upto(energy_levels.first.length - 1) do |col|
          next unless energy_levels[row][col] > 9 && !flashed[row][col]

          flash(energy_levels, flashed, row, col)
        end
      end

      0.upto(energy_levels.length - 1) do |row|
        0.upto(energy_levels.first.length - 1) do |col|
          next unless flashed[row][col]

          energy_levels[row][col] = 0
          flashed[row][col] = false
          flashes += 1
        end
      end

      # if (step + 1) <= 10 || ((step + 1) % 10).zero?
      #   puts "After step #{step + 1}:\n#{energy_levels.map(&:join).join("\n")}\n\n"
      #   puts "Flashes: #{flashes}\n\n"
      # end
    end

    flashes
  end
end

puts Answer.new.main
