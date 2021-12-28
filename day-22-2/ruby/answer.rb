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

  def cube_size(ranges)
    ranges.reduce(1) { |size, range| size * range.size }
  end

  def overlaps?(ranges_a, ranges_b)
    result = true

    0.upto(2) do |index|
      result &&= (ranges_a[index].cover?(ranges_b[index].first) ||
                  ranges_b[index].cover?(ranges_a[index].first))
    end

    result
  end

  def overlap(ranges_a, ranges_b)
    overlap = []

    0.upto(2) do |index|
      overlap_start = [ranges_a[index].first, ranges_b[index].first].max
      overlap_end = [ranges_a[index].last, ranges_b[index].last].min
      overlap.append(overlap_start..overlap_end)
    end

    overlap
  end

  def overlap_size(ranges_a, ranges_b)
    overlaps?(ranges_a, ranges_b) ? cube_size(overlap(ranges_a, ranges_b)) : 0
  end

  def main
    starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    steps = parse_input(self.class.read_input_file)

    total = 0
    overlaps = { 0 => [] }

    steps.each do |step|
      state, ranges = step

      total += cube_size(ranges) if state

      signal = -1
      0.upto(overlaps.keys.max) do |level|
        level_overlaps = (overlaps[level] ||= [])

        level_overlaps.each do |current_overlap|
          next unless overlaps?(current_overlap, ranges)

          total += signal * overlap_size(current_overlap, ranges)
        end

        signal *= -1
      end

      overlaps.keys.max.downto(0) do |level|
        level_overlaps = (overlaps[level] ||= [])

        level_overlaps.each do |current_overlap|
          next unless overlaps?(current_overlap, ranges)

          (overlaps[level + 1] ||= []) << overlap(current_overlap, ranges)
        end
      end

      (overlaps[0] ||= []) << ranges if state
    end

    ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    puts "elapsed: #{ending - starting} seconds"

    total
  end
end

puts Answer.new.main
