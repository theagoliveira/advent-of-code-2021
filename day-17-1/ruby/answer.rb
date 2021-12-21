# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def parse_input(input)
    input.gsub(/target area: x=|\.\.|, y=/, ',').split(',')[1..-1].map(&:to_i)
  end

  def hits_target(vx, vy, x_min, x_max, y_min, y_max)
    sx = sy = 0
    max_y = 0

    loop do
      sx += vx
      sy += vy

      max_y = sy if sy > max_y

      return [true, max_y] if inside_target(sx, sy, x_min, x_max, y_min, y_max)
      return [false, max_y] if after_target(sx, sy, x_min, x_max, y_min, y_max)

      if vx.positive?
        vx -= 1
      elsif vx.negative?
        vx += 1
      end

      vy -= 1
    end
  end

  def inside_target(sx, sy, x_min, x_max, y_min, y_max)
    sx >= x_min && sx <= x_max && sy >= y_min && sy <= y_max
  end

  def after_target(sx, sy, x_min, x_max, y_min, y_max)
    sx > x_max || sy < y_min
  end

  def main
    x_min, x_max, y_min, y_max = parse_input(self.class.read_input_file)

    max_y = 0

    min_vx = 1
    max_vx = x_max

    min_vy = y_min
    max_vy = 1000 # ?

    min_vx.upto(max_vx) do |vx|
      min_vy.upto(max_vy) do |vy|
        result, y_reached = hits_target(vx, vy, x_min, x_max, y_min, y_max)

        next unless result && y_reached > max_y

        max_y = y_reached
      end
    end

    max_y
  end
end

puts Answer.new.main
