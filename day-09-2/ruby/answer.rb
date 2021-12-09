# frozen_string_literal: true
require 'set'

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def generate_neighbors(row, col)
    [
      [row - 1, col], # up
      [row + 1, col], # down
      [row, col - 1], # left
      [row, col + 1]  # right
    ]
  end

  def generate_discovered_array(matrix)
    discovered = []
    matrix.size.times { discovered.append([false] * matrix.first.size) }
    discovered
  end

  def is_valid?(matrix, row, col)
    row >= 0 && row <= matrix.length - 1 &&
      col >= 0 && col <= matrix.first.length - 1
  end

  def is_inside_basin?(matrix, row, col)
    is_valid?(matrix, row, col) && matrix[row][col] != 9
  end

  def main
    heightmap = self.class.read_input_file.split("\n").map(&:chars).each do |line|
      line.map!(&:to_i)
    end

    low_points = Set.new
    point_queue = []
    point_queue.append([0, 0])
    discovered = generate_discovered_array(heightmap)
    discovered[0][0] = true

    while point_queue.size.positive?
      current_coordinates = point_queue.shift
      current_row, current_col = current_coordinates

      neighbors = generate_neighbors(current_row, current_col)

      is_low_point = true

      neighbors.each do |neighbor|
        neighbor_row, neighbor_col = neighbor

        next unless is_valid?(heightmap, neighbor_row, neighbor_col)

        point_queue.append(neighbor) unless discovered[neighbor_row][neighbor_col]
        discovered[neighbor_row][neighbor_col] = true
        is_low_point &&= heightmap[neighbor_row][neighbor_col] > heightmap[current_row][current_col]
      end

      low_points.add(current_coordinates) if is_low_point
    end

    basin_sizes = []
    low_points = low_points.to_a

    while low_points.size.positive?
      basin_start = low_points.shift
      basin_start_row, basin_start_col = basin_start

      basin_size = 1
      basin_queue = []
      basin_queue.append(basin_start)
      discovered = generate_discovered_array(heightmap)
      discovered[basin_start_row][basin_start_col] = true

      while basin_queue.size.positive?
        current_row, current_col = basin_queue.shift

        neighbors = generate_neighbors(current_row, current_col)

        neighbors.each do |neighbor|
          neighbor_row, neighbor_col = neighbor

          next unless is_inside_basin?(heightmap, neighbor_row, neighbor_col)

          unless discovered[neighbor_row][neighbor_col]
            basin_queue.append(neighbor)
            basin_size += 1
          end

          discovered[neighbor_row][neighbor_col] = true
        end
      end

      basin_sizes.append(basin_size)
    end

    basin_sizes.sort[-3..].reduce(:*)
  end
end

puts Answer.new.main
