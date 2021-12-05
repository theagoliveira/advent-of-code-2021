# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def main
    data = self.class.read_input_file.split("\n")
    readings = get_readings(data)
    diagram = generate_diagram(readings)

    readings.each do |reading|
      point1 = reading[0]
      point2 = reading[1]

      x1 = point1[0]
      y1 = point1[1]

      x2 = point2[0]
      y2 = point2[1]

      if (y1 == y2) # same y coordinates = same row = horizontal line
        draw_horizontal(diagram, y1, x1, x2)
      elsif (x1 == x2) # same x coordinates = same column = vertical line
        draw_vertical(diagram, x1, y1, y2)
      else
        draw_diagonal(diagram, y1, y2, x1, x2)
      end
    end

    diagram.flatten.count { |number| number > 1 }
  end

  def get_readings(data)
    data.map do |reading|
      reading.split(' -> ').map { |point| point.split(',').map(&:to_i) }
    end
  end

  def generate_diagram(readings)
    row_size = readings.map { |reading| reading.map(&:last) }.flatten.max + 1
    col_size = readings.map { |reading| reading.map(&:first) }.flatten.max + 1

    diagram = []
    row_size.times { diagram.append([0] * col_size)  }

    diagram
  end

  def draw_horizontal(diagram, row, col1, col2)
    beginning = [col1, col2].min
    ending = [col1, col2].max

    beginning.upto(ending).each do |col|
      diagram[row][col] += 1
    end
  end

  def draw_vertical(diagram, col, row1, row2)
    beginning = [row1, row2].min
    ending = [row1, row2].max

    beginning.upto(ending).each do |row|
      diagram[row][col] += 1
    end
  end

  def draw_diagonal(diagram, row1, row2, col1, col2)
    row_increment = 1
    row_increment = -1 if row1 > row2

    col_increment = 1
    col_increment = -1 if col1 > col2

    row = row1
    col = col1

    loop do
      diagram[row][col] += 1

      break if row == row2

      row += row_increment
      col += col_increment
    end
  end
end

puts Answer.new.main
