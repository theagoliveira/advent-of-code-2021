# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def parse_input(input)
    input.split("\n").map do |line|
      line.split(' ').map! do |element|
        if %w[on off].include?(element)
          element == 'on'
        else
          element.gsub(/,|x=/, '').split(/[y-z]=/).map! { |range| eval(range) }
        end
      end
    end
  end

  def false_cube(size)
    cube = []
    grid = []

    size.times { grid.append([false] * size) }

    size.times { cube.append(grid.clone.map(&:clone)) }

    cube
  end

  def change_state(reactor, state, ranges)
    pages, rows, cols = ranges
    # puts "change_state(#{state}, #{ranges}) - changes: #{pages.size * rows.size * cols.size}"

    pages.each do |page|
      next if page < -50 || page > 50

      page += 50

      rows.each do |row|
        next if row < -50 || row > 50

        row += 50

        cols.each do |col|
          next if col < -50 || col > 50

          col += 50

          next if reactor[page][row][col] == state

          reactor[page][row][col] = state
        end
      end
    end
  end

  def main
    steps = parse_input(self.class.read_input_file)

    reactor = false_cube(101)

    steps.each do |step|
      change_state(reactor, *step)
    end

    reactor.flatten.count(true)
  end
end

puts Answer.new.main
