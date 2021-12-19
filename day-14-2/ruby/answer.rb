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
    insertions = Hash.new(0)

    polymer_template.chars.each { |element| counters[element] += 1 }
    (polymer_template.length - 1).times do |index|
      insertions[polymer_template[index..(index + 1)]] += 1
    end

    40.times do
      insertions.dup.each do |insertion, count|
        next if count.zero?

        inserted = pair_insertion_rules[insertion]
        counters[inserted] += count
        insertions[insertion[0] + inserted] += count
        insertions[inserted + insertion[1]] += count
        insertions[insertion] -= count
      end
    end

    counts = counters.values
    counts.max - counts.min
  end
end

puts Answer.new.main
