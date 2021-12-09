# frozen_string_literal: true
require 'set'

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def is_valid?(matrix, row, col)
    row >= 0 && row <= matrix.length - 1 &&
      col >= 0 && col <= matrix.first.length - 1
  end

  def main
    heightmap = self.class.read_input_file.split("\n").map(&:chars).each do |line|
      line.map!(&:to_i)
    end

    point_queue = []
    low_points = Set.new
    discovered = []

    point_queue.append([0, 0])
    heightmap.size.times { discovered.append([false] * heightmap.first.size) }
    discovered[0][0] = true

    while point_queue.size.positive?
      current_coordinates = point_queue.shift
      current_row = current_coordinates.first
      current_col = current_coordinates.last

      neighbors = [
        [current_row - 1, current_col], # up
        [current_row + 1, current_col], # down
        [current_row, current_col - 1], # left
        [current_row, current_col + 1]  # right
      ]

      is_low_point = true

      neighbors.each do |neighbor|
        neighbor_row = neighbor.first
        neighbor_col = neighbor.last

        next unless is_valid?(heightmap, neighbor_row, neighbor_col)

        point_queue.append(neighbor) unless discovered[neighbor_row][neighbor_col]
        discovered[neighbor_row][neighbor_col] = true
        is_low_point &&= heightmap[neighbor_row][neighbor_col] > heightmap[current_row][current_col]
      end

      low_points.add(current_coordinates) if is_low_point
    end

    low_points.map{ |point| heightmap[point.first][point.last] }.sum + low_points.size
  end
end

puts Answer.new.main
