# frozen_string_literal: true

require 'algorithms'
require 'set'

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
      [row, col - 1], # left
      [row, col + 1], # right
      [row - 1, col], # top
      [row + 1, col]  # bottom
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

  def increment_array(array, increment)
    array.map do |element|
      element + increment <= 9 ? element + increment : element + increment - 9
    end
  end

  def increase_matrix(matrix)
    new_matrix = matrix.map do |line|
      original_line = line.dup

      1.upto(4) do |increment|
        line.append(*increment_array(original_line, increment))
      end

      line
    end

    original_matrix = matrix.dup
    1.upto(4) do |increment|
      original_matrix.each do |line|
        new_matrix.append(increment_array(line.dup, increment))
      end
    end

    new_matrix
  end

  def manhattan_distance(current_row, current_col, end_row, end_col)
    (current_row - end_row).abs + (current_col - end_col).abs
  end

  def manhanttan_distance_matrix(matrix, target_row, target_col)
    manhanttan_distance_matrix = matrix.clone.map(&:clone)
    manhanttan_distance_matrix.length.times do |row|
      manhanttan_distance_matrix.first.length.times do |col|
        manhanttan_distance_matrix[row][col] = manhattan_distance(row, col, target_row, target_col)
      end
    end

    manhanttan_distance_matrix
  end

  def main
    risk_level_map = parse_input(self.class.read_input_file)
    real_map = increase_matrix(risk_level_map)

    exit_row = real_map.length - 1
    exit_col = real_map.first.length - 1

    known = false_matrix(real_map)
    dist = infinity_matrix(real_map)
    heuristic = manhanttan_distance_matrix(real_map, exit_row, exit_col)
    priority_queue = Containers::PriorityQueue.new
    in_queue = Set.new

    known[0][0] = true
    dist[0][0] = 0

    neighbors(real_map, 0, 0, known).each do |(row, col)|
      dist[row][col] = real_map[row][col]
      in_queue.add([row, col])
      priority_queue.push([row, col], -(dist[row][col] + heuristic[row][col]))
    end

    last = [0, 0]

    while last != [exit_row, exit_col]
      next_row, next_col = priority_queue.pop

      neighbors(real_map, next_row, next_col, known).each do |(row, col)|
        dist[row][col] = [dist[row][col], dist[next_row][next_col] + real_map[row][col]].min

        unless in_queue.include?([row, col])
          priority_queue.push([row, col], -(dist[row][col] + heuristic[row][col]))
          in_queue.add([row, col])
        end
      end

      last = [next_row, next_col]
      known[next_row][next_col] = true
    end

    dist[exit_row][exit_col]
  end
end

puts Answer.new.main
