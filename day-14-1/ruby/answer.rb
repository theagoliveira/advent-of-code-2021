# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def parse_input(input)
    polymer_template, pair_insertion_rules_input = input.split("\n\n")

    pair_insertion_rules = {}
    pair_insertion_rules_input.split("\n").each do |line|
      key, value = line.split(' -> ')
      pair_insertion_rules[key] = value
    end

    [polymer_template, pair_insertion_rules]
  end

  def main
    polymer_template, pair_insertion_rules = parse_input(self.class.read_input_file)

    counters = Hash.new(0)
    polymer_template.chars.each { |element| counters[element] += 1 }

    10.times do
      # puts polymer_template

      new_template = []

      (polymer_template.size - 1).times do |i|
        new_element = pair_insertion_rules[polymer_template[i..(i + 1)]]

        new_template.append(polymer_template[i])
        new_template.append(new_element)
        new_template.append(polymer_template[i + 1]) if i == polymer_template.size - 2

        counters[new_element] += 1
      end

      polymer_template = new_template.join
    end

    # CODE

    counters.values.max - counters.values.min
  end
end

puts Answer.new.main
