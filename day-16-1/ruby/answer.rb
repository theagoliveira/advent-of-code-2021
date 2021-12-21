# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def parse_input(input)
    bin_str = input.to_i(16).to_s(2)
    four_remainder = bin_str.size % 4

    return '0' * (4 - four_remainder) + bin_str unless four_remainder.zero?

    bin_str
  end

  def bin_to_int(data, start, offset)
    data[start..(start + offset)].to_i(2)
  end

  def header(data, packet_hash, start)
    type_id_offset = 3
    type_id_length = 3
    offset = 0

    version = bin_to_int(data, start + offset, 2)
    offset += type_id_offset
    type_id = bin_to_int(data, start + offset, 2)
    offset += type_id_length

    packet_hash.update(version: version, type_id: type_id)

    offset
  end

  def literal_value(data, packet_hash, start)
    offset = 0
    literal_value = 0
    last_group = false

    until last_group
      last_group = data[start + offset] == '0'

      offset += 1
      literal_value = (literal_value << 4) + bin_to_int(data, start + offset, 3)

      offset += 4
    end

    packet_hash.update(literal_value: literal_value)

    offset
  end

  def length_type_id(data, packet_hash, start)
    offset = 0

    packet_hash.update(length_type_id: data[start].to_i)
    offset += 1

    offset
  end

  def total_length(data, packet_hash, start)
    offset = 0

    packet_hash.update(total_length: bin_to_int(data, start + offset, 14))
    offset += 15

    offset
  end

  def number_of_sub_packets(data, packet_hash, start)
    offset = 0

    packet_hash.update(number_of_sub_packets: bin_to_int(data, start + offset, 10))
    offset += 11

    offset
  end

  def parse(data, packet_hash, start)
    offset = 0
    offset += header(data, packet_hash, start + offset)

    if packet_hash[:type_id] == 4
      offset += literal_value(data, packet_hash, start + offset)
      packet_hash.update(sub_packets: [])
    else
      offset += length_type_id(data, packet_hash, start + offset)

      if packet_hash[:length_type_id].zero?
        offset += total_length(data, packet_hash, start + offset)
        prev_offset = offset

        packet_hash.update(sub_packets: [])

        while offset - prev_offset < packet_hash[:total_length]
          new_packet = {}

          offset += parse(data, new_packet, start + offset)

          packet_hash[:sub_packets].append(new_packet)
        end
      else
        offset += number_of_sub_packets(data, packet_hash, start + offset)
        sub_packet_counter = 0

        packet_hash.update(sub_packets: [])

        while sub_packet_counter < packet_hash[:number_of_sub_packets]
          new_packet = {}

          offset += parse(data, new_packet, start + offset)

          packet_hash[:sub_packets].append(new_packet)

          sub_packet_counter += 1
        end
      end
    end

    offset
  end

  def sum_versions(packet_hash)
    result = 0

    result += packet_hash[:version]

    unless packet_hash[:sub_packets].empty?
      packet_hash[:sub_packets].each do |sub_packet_hash|
        result += sum_versions(sub_packet_hash)
      end
    end

    result
  end

  def main
    packet = parse_input(self.class.read_input_file)
    packet_hash = {}

    parse(packet, packet_hash, 0)

    sum_versions(packet_hash)
  end
end

puts Answer.new.main
