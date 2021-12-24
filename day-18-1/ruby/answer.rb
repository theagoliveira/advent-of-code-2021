# frozen_string_literal: true

require 'yaml'

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def parse_input(input)
    input.split("\n").map { |str| YAML.load(str) }
  end

  def add(x, y)
    [x, y]
  end

  def reduce_actions_apply(number, level)
    result = (pair?(number) && level >= 4) || (number.instance_of?(Integer) && number >= 10)

    if number.instance_of?(Array)
      result ||= reduce_actions_apply(number.first, level + 1)
      result ||= reduce_actions_apply(number.last, level + 1)
    end

    result
  end

  def explosion_actions_apply(number, level)
    result = (pair?(number) && level >= 4)

    if number.instance_of?(Array)
      result ||= explosion_actions_apply(number.first, level + 1)
      result ||= explosion_actions_apply(number.last, level + 1)
    end

    result
  end

  def splitting_actions_apply(number, level)
    result = number.instance_of?(Integer) && number >= 10

    if number.instance_of?(Array)
      result ||= splitting_actions_apply(number.first, level + 1)
      result ||= splitting_actions_apply(number.last, level + 1)
    end

    result
  end

  def reduce(number, level, left, left_index, right, right_index, applied, all)
    return if applied[0]

    if pair?(number.first) && level >= 3 && !applied[0]
      prev_left = left
      prev_left_index = left_index
      if left_index == -1
        until prev_left.last.instance_of?(Integer)
          prev_left = prev_left.last
        end

        prev_left_index = 1
      end
      prev_left[prev_left_index] += number.first.first

      if number.last.instance_of?(Integer)
        prev_right = number
        prev_right_index = 1
      else
        prev_right = number.last

        until prev_right.first.instance_of?(Integer)
          prev_right = prev_right.first
        end

        prev_right_index = 0
      end
      prev_right[prev_right_index] += number.first.last

      number[0] = 0

      applied[0] = true
    end

    if pair?(number.last) && level >= 3 && !applied[0]
      if number.first.instance_of?(Integer)
        prev_left = number
        prev_left_index = 0
      else
        prev_left = number.first

        until prev_left.last.instance_of?(Integer)
          prev_left = prev_left.last
        end

        prev_left_index = 1
      end
      prev_left[prev_left_index] += number.last.first

      prev_right = right
      prev_right_index = right_index
      if right_index == -1
        until prev_right.first.instance_of?(Integer)
          prev_right = prev_right.first
        end

        prev_right_index = 0
      end
      prev_right[prev_right_index] += number.last.last

      number[1] = 0

      applied[0] = true
    end

    if number.first.instance_of?(Integer) && number.first >= 10 && !applied[0]
      applied[0] = true
      number[0] = split(number.first)
    end

    if number.last.instance_of?(Integer) && number.last >= 10 && !applied[0]
      applied[0] = true
      number[1] = split(number.last)
    end

    curr_left = number.first
    curr_right = number.last

    next_level = level + 1

    if curr_left.instance_of?(Array)
      if curr_right.instance_of?(Array)
        next_right = curr_right
        next_right_index = -1
      else
        next_right = number
        next_right_index = 1
      end

      reduce(curr_left, next_level,
             left, left_index,
             next_right, next_right_index,
             applied, all)
    end

    if curr_right.instance_of?(Array)
      if curr_left.instance_of?(Array)
        next_left = curr_left
        next_left_index = -1
      else
        next_left = number
        next_left_index = 0
      end

      reduce(curr_right, next_level,
             next_left, next_left_index,
             right, right_index,
             applied, all)
    end
  end

  def reduce_explode(number, level, left, left_index, right, right_index, applied, all)
    return if applied[0]

    curr_left = number.first
    curr_right = number.last

    next_level = level + 1

    if pair?(number.first) && level >= 3 && !applied[0]

      # puts "\nreduce_explode"
      # puts "number: #{number}"
      # puts "level: #{level}"
      # puts "left: #{left}"
      # puts "left_index: #{left_index}"
      # puts "right: #{right}"
      # puts "right_index: #{right_index}"
      # puts "all: #{all}"
      # puts "exploding #{number.first}"

      prev_left = left
      prev_left_index = left_index
      if left_index == -1
        until prev_left.last.instance_of?(Integer)
          prev_left = prev_left.last
        end

        prev_left_index = 1
      end
      prev_left[prev_left_index] += number.first.first

      if number.last.instance_of?(Integer)
        prev_right = number
        prev_right_index = 1
      else
        prev_right = number.last

        until prev_right.first.instance_of?(Integer)
          prev_right = prev_right.first
        end

        prev_right_index = 0
      end
      prev_right[prev_right_index] += number.first.last

      number[0] = 0

      applied[0] = true
    end

    if curr_left.instance_of?(Array)
      if curr_right.instance_of?(Array)
        next_right = curr_right
        next_right_index = -1
      else
        next_right = number
        next_right_index = 1
      end

      reduce_explode(curr_left, next_level,
                     left, left_index,
                     next_right, next_right_index,
                     applied, all)
    end

    if pair?(number.last) && level >= 3 && !applied[0]
      # puts "\nreduce_explode"
      # puts "number: #{number}"
      # puts "level: #{level}"
      # puts "left: #{left}"
      # puts "left_index: #{left_index}"
      # puts "right: #{right}"
      # puts "right_index: #{right_index}"
      # puts "all: #{all}"
      # puts "exploding #{number.last}"

      if number.first.instance_of?(Integer)
        prev_left = number
        prev_left_index = 0
      else
        prev_left = number.first

        until prev_left.last.instance_of?(Integer)
          prev_left = prev_left.last
        end

        prev_left_index = 1
      end
      prev_left[prev_left_index] += number.last.first

      prev_right = right
      prev_right_index = right_index
      if right_index == -1
        until prev_right.first.instance_of?(Integer)
          prev_right = prev_right.first
        end

        prev_right_index = 0
      end
      prev_right[prev_right_index] += number.last.last

      number[1] = 0

      applied[0] = true
    end

    if curr_right.instance_of?(Array)
      if curr_left.instance_of?(Array)
        next_left = curr_left
        next_left_index = -1
      else
        next_left = number
        next_left_index = 0
      end

      reduce_explode(curr_right, next_level,
                     next_left, next_left_index,
                     right, right_index,
                     applied, all)
    end
  end

  def reduce_split(number, level, applied, all)
    return if applied[0]

    curr_left = number.first
    curr_right = number.last

    next_level = level + 1

    if number.first.instance_of?(Integer) && number.first >= 10 && !applied[0]
      # puts "\nreduce_split"
      # puts "number: #{number}"
      # puts "level: #{level}"
      # puts "all: #{all}"
      # puts "splitting #{number.first}"
      applied[0] = true
      number[0] = split(number.first)
    end

    if curr_left.instance_of?(Array)
      reduce_split(curr_left, next_level,
                   applied, all)
    end

    if number.last.instance_of?(Integer) && number.last >= 10 && !applied[0]
      # puts "\nreduce_split"
      # puts "number: #{number}"
      # puts "level: #{level}"
      # puts "all: #{all}"
      # puts "splitting #{number.last}"
      applied[0] = true
      number[1] = split(number.last)
    end

    if curr_right.instance_of?(Array)
      reduce_split(curr_right, next_level,
                   applied, all)
    end
  end

  def split(number)
    div = number / 2.0
    [div.floor, div.ceil]
  end

  def magnitude(number)
    if number.instance_of?(Integer)
      return number
    end

    3 * magnitude(number.first) + 2 * magnitude(number.last)
  end

  def add_all(numbers)
    total = numbers.shift

    numbers.each do |number|
      # puts "\n"
      # puts "  #{total}"
      # puts "+ #{number}"
      total = add(total, number)

      while reduce_actions_apply(total, 0)
        while explosion_actions_apply(total, 0)
          # puts 'explosion_actions_apply'
          reduce_explode(total, 0, [0, 0], 1, [0, 0], 0, [false], total)
        end

        if splitting_actions_apply(total, 0)
          # puts 'splitting_actions_apply'
          reduce_split(total, 0, [false], total)
          next
        end
      end

      # puts "= #{total}"
    end

    total
  end

  def pair?(number)
    number.instance_of?(Array) &&
      number.first.instance_of?(Integer) &&
      number.last.instance_of?(Integer)
  end

  def main
    numbers = parse_input(self.class.read_input_file)

    total = add_all(numbers)
    # puts "total: #{total}"

    magnitude(total)
  end
end

puts Answer.new.main
