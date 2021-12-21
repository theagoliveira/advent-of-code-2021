# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'answer'

class AnswerTest < Minitest::Test
  HEADER_SIZE = 6

  EXAMPLE1 = 'D2FE28'
  PARSED_EXAMPLE1 = '110100101111111000101000'
  EXAMPLE1_EXTRA_ZEROS = 3

  EXAMPLE2 = '38006F45291200'
  PARSED_EXAMPLE2 = '00111000000000000110111101000101001010010001001000000000'
  EXAMPLE2_EXTRA_ZEROS = 7

  EXAMPLE3 = '8A004A801A8002F478'
  EXAMPLE4 = '620080001611562C8802118E34'
  EXAMPLE5 = 'C0015000016115A2E0802F182340'
  EXAMPLE6 = 'A0016C880162017C3686B18A3D4780'

  def test_parse_input1
    skip
    assert_equal PARSED_EXAMPLE1, Answer.new.parse_input(EXAMPLE1)
  end

  def test_parse_input2
    skip
    assert_equal PARSED_EXAMPLE2, Answer.new.parse_input(EXAMPLE2)
  end

  def test_header1
    skip
    parsed_packet = {}
    pointer = 0

    pointer += Answer.new.header(PARSED_EXAMPLE1, parsed_packet, 0)

    assert_equal({ version: 6, type_id: 4 }, parsed_packet)
    assert_equal HEADER_SIZE, pointer
  end

  def test_header2
    skip
    parsed_packet = {}
    pointer = 0

    pointer += Answer.new.header(PARSED_EXAMPLE2, parsed_packet, 0)

    assert_equal({ version: 1, type_id: 6 }, parsed_packet)
    assert_equal HEADER_SIZE, pointer
  end

  def test_literal_value
    skip
    parsed_packet = {}
    pointer = 0

    pointer += Answer.new.header(PARSED_EXAMPLE1, parsed_packet, pointer)
    pointer += Answer.new.literal_value(PARSED_EXAMPLE1, parsed_packet, pointer)

    assert_equal({ version: 6, type_id: 4, literal_value: 2021 }, parsed_packet)
    assert_equal PARSED_EXAMPLE1.size - EXAMPLE1_EXTRA_ZEROS, pointer
  end

  def test_total_length
    skip
    parsed_packet = {}
    pointer = 0

    pointer += Answer.new.header(PARSED_EXAMPLE2, parsed_packet, pointer)
    pointer += Answer.new.length_type_id(PARSED_EXAMPLE2, parsed_packet, pointer)
    pointer += Answer.new.total_length(PARSED_EXAMPLE2, parsed_packet, pointer)

    assert_equal({ version: 1, type_id: 6, length_type_id: 0, total_length: 27 }, parsed_packet)
    assert_equal 22, pointer
  end

  def test_parse1
    skip
    parsed_packet = {}
    pointer = 0

    pointer += Answer.new.parse(PARSED_EXAMPLE1, parsed_packet, pointer)

    assert_equal({ version: 6, type_id: 4, literal_value: 2021, sub_packets: [] }, parsed_packet)
    assert_equal PARSED_EXAMPLE1.size - EXAMPLE1_EXTRA_ZEROS, pointer
  end

  def test_parse2
    skip
    parsed_packet = {}
    pointer = 0

    pointer += Answer.new.parse(PARSED_EXAMPLE2, parsed_packet, pointer)

    assert_equal(
      { version: 1,
        type_id: 6,
        length_type_id: 0,
        total_length: 27,
        sub_packets: [
          { version: 6,
            type_id: 4,
            literal_value: 10,
            sub_packets: [] },
          { version: 2,
            type_id: 4,
            literal_value: 20,
            sub_packets: [] }
        ] },
      parsed_packet
    )
    assert_equal PARSED_EXAMPLE2.size - EXAMPLE2_EXTRA_ZEROS, pointer
  end

  def test_main1
    # skip
    Answer.stub(:read_input_file, EXAMPLE3) do
      assert_equal 16, Answer.new.main
    end
  end

  def test_main2
    # skip
    Answer.stub(:read_input_file, EXAMPLE4) do
      assert_equal 12, Answer.new.main
    end
  end

  def test_main3
    # skip
    Answer.stub(:read_input_file, EXAMPLE5) do
      assert_equal 23, Answer.new.main
    end
  end

  def test_main4
    # skip
    Answer.stub(:read_input_file, EXAMPLE6) do
      assert_equal 31, Answer.new.main
    end
  end
end
