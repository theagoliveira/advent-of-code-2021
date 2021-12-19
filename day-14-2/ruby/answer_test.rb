# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  EXAMPLE = "NNCB\n\n" \
            "CH -> B\n" \
            "HH -> N\n" \
            "CB -> H\n" \
            "NH -> C\n" \
            "HB -> C\n" \
            "HC -> B\n" \
            "HN -> C\n" \
            "NN -> C\n" \
            "BH -> H\n" \
            "NC -> B\n" \
            "NB -> B\n" \
            "BN -> B\n" \
            "BB -> N\n" \
            "BC -> B\n" \
            "CC -> N\n" \
            'CN -> C'

  PARSED_EXAMPLE = [
    'NNCB',
    { 'CH' => 'B',
      'HH' => 'N',
      'CB' => 'H',
      'NH' => 'C',
      'HB' => 'C',
      'HC' => 'B',
      'HN' => 'C',
      'NN' => 'C',
      'BH' => 'H',
      'NC' => 'B',
      'NB' => 'B',
      'BN' => 'B',
      'BB' => 'N',
      'BC' => 'B',
      'CC' => 'N',
      'CN' => 'C' }
  ].freeze

  def test_parse_input
    skip
    assert_equal PARSED_EXAMPLE, Answer.new.parse_input(EXAMPLE)
  end

  def test_main
    # skip
    Answer.stub(:read_input_file, EXAMPLE) do
      assert_equal 2_188_189_693_529, Answer.new.main
    end
  end
end
