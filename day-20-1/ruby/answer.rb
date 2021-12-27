# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def parse_input(input)
    data = input.split("\n")
    algorithm = data.shift.chars.map { |elem| elem == '.' ? 0 : 1 }
    data.shift
    image = data.map { |str| str.chars.map! { |elem| elem == '.' ? 0 : 1 } }

    [algorithm, image]
  end

  def valid?(image, row, col)
    row >= 0 && row <= image.length - 1 &&
      col >= 0 && col <= image[0].length - 1
  end

  def main
    algorithm, image = parse_input(self.class.read_input_file)

    zero_line = [0] * image.length
    image = [zero_line, zero_line.dup] + image + [zero_line.dup, zero_line.dup]
    image.map! { |line| [0, 0] + line + [0, 0] }

    infinity_pixel = 0

    2.times do
      new_image = image.clone.map(&:clone)

      image.length.times do |row|
        image[0].length.times do |col|
          index = 0

          (row - 1).upto(row + 1) do |sub_row|
            (col - 1).upto(col + 1) do |sub_col|
              index <<= 1

              if valid?(image, sub_row, sub_col)
                index += image[sub_row][sub_col]
              else
                index += infinity_pixel
              end
            end
          end

          new_image[row][col] = algorithm[index]
        end
      end

      image = new_image
      infinity_pixel = infinity_pixel.zero? ? algorithm[0] : algorithm[511]
    end

    image.reduce(0) { |count, elem| count + elem.count(1) }
  end
end

puts Answer.new.main
