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

  def valid?(matrix, neighbor, known)
    row, col = neighbor

    row >= 0 && row <= matrix.length - 1 &&
      col >= 0 && col <= matrix.first.length - 1 &&
      !known[row][col]
  end

  def neighbors(matrix, row, col, known)
    [
      [row + 0, col - 1], # left
      [row + 0, col + 1], # right
      [row - 1, col + 0], # top
      [row + 1, col + 0]  # bottom
    ].select { |neighbor| valid?(matrix, neighbor, known) }
  end

  def false_matrix(matrix)
    false_matrix = []
    matrix.length.times { false_matrix.append([false] * matrix.first.length) }
    false_matrix
  end

  def infinity_matrix(matrix)
    infinity_matrix = []
    matrix.length.times { infinity_matrix.append([Float::INFINITY] * matrix.first.length) }
    infinity_matrix
  end

  def main
    risk_level_map = parse_input(self.class.read_input_file)

    # Dijkstra's Algorithm (Source: Skiena)
    known = false_matrix(risk_level_map)
    dist = infinity_matrix(risk_level_map)
    known[0][0] = true
    dist[0][0] = 0

    neighbors(risk_level_map, 0, 0, known).each do |(row, col)|
      dist[row][col] = risk_level_map[row][col]
    end

    last = [0, 0]

    while last != [risk_level_map.length - 1, risk_level_map.first.length - 1]
      next_row = nil
      next_col = nil

      min_dist = Float::INFINITY
      risk_level_map.length.times do |row|
        risk_level_map.first.length.times do |col|
          next unless !known[row][col] && min_dist > dist[row][col]

          min_dist = dist[row][col]
          next_row = row
          next_col = col
        end
      end

      neighbors(risk_level_map, next_row, next_col, known).each do |(row, col)|
        dist[row][col] = [dist[row][col], dist[next_row][next_col] + risk_level_map[row][col]].min
      end

      last = [next_row, next_col]
      known[next_row][next_col] = true
    end

    dist[risk_level_map.length - 1][risk_level_map.first.length - 1]
  end
end

puts Answer.new.main
