# frozen_string_literal: true

require 'matrix'
require 'set'

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def parse_input(input)
    input.split(/--- scanner [0-9]+ ---\n|\n\n/)
         .reject(&:empty?)
         .each_slice(1)
         .to_a
         .map do |arr|
           arr[0].split("\n").map! do |num_str|
             num_str.split(',').map!(&:to_i)
           end
         end
  end

  def rotations
    id = Matrix.rows([[1, 0, 0], [0, 1, 0], [0, 0, 1]])
    rx = Matrix.rows([[1, 0, 0], [0, 0, -1], [0, 1, 0]])
    ry = Matrix.rows([[0, 0, 1], [0, 1, 0], [-1, 0, 0]])
    rz = Matrix.rows([[0, -1, 0], [1, 0, 0], [0, 0, 1]])

    result = []

    #     0
    #     x    xx     xxx
    #     z           zzz

    #    y
    #    yx   yxx    yxxx
    #    yz          yzzz

    #   yy
    #   yyx  yyxx   yyxxx
    #   yyz         yyzzz

    #  yyy
    #  yyyx yyyxx  yyyxxx
    #  yyyz        yyyzzz

    roty = id
    4.times do
      result.append(roty)
      roty_dup = roty.dup

      rotx = roty_dup * rx
      3.times do
        result.append(rotx)
        rotx *= rx
      end

      rotz = roty_dup * rz
      2.times do
        result.append(rotz)
        rotz *= (rz * rz)
      end

      roty *= ry
    end

    result
  end

  def main
    scanners = parse_input(self.class.read_input_file)

    beacons = Set.new

    next_ref = [0]
    checked = []
    updated = []
    correct_deltas = { 0 => [0, 0, 0] }
    correct_rotations = { 0 => rotations.first }

    while next_ref.size.positive?
      current_ref = next_ref.pop
      reference = scanners[current_ref]
      reference.each { |reading| beacons.add(reading) }

      scanners.each_with_index do |readings, scanner_num|
        next if readings == reference || checked.include?(scanner_num)

        # puts "scanner_num: #{scanner_num}"

        rotations.each do |rotation|
          deltas = Hash.new(0)

          readings.each do |reading|
            rotated = (rotation * Matrix.columns([reading])).to_a.flatten

            reference.each do |ref_reading|
              delta = [0] * 3

              0.upto(2) do |index|
                delta[index] = ref_reading[index] - rotated[index]
              end

              deltas[delta] += 1

              if deltas[delta] == 12
                correct_deltas[scanner_num] = delta
                correct_rotations[scanner_num] = rotation
                # puts "found for scanner #{scanner_num}"
                # puts "correct_deltas[#{scanner_num}]:    #{correct_deltas[scanner_num]}"
                # puts "correct_rotations[#{scanner_num}]: #{correct_rotations[scanner_num]}"
                break
              end
            end
          end

          if !correct_deltas[scanner_num].nil? && !updated.include?(scanner_num)
            # puts "updating scanner #{scanner_num}"
            # puts "scanners[#{scanner_num}] before: #{scanners[scanner_num]}"

            scanners[scanner_num].map! do |reading|
              new_reading = (correct_rotations[scanner_num] * Matrix.columns([reading])).to_a.flatten

              0.upto(2) do |index|
                new_reading[index] += correct_deltas[scanner_num][index]
              end

              new_reading
            end

            # puts "scanners[#{scanner_num}] after: #{scanners[scanner_num]}"

            next_ref.push(scanner_num)
            updated.push(scanner_num)

            break
          end
        end
      end

      checked.push(current_ref)
    end

    beacons.size
  end
end

puts Answer.new.main
