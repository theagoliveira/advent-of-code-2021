# frozen_string_literal: true

class Answer
  class << self
    def read_input_file
      File.read('./input.txt')
    end

    def split_data(data, char)
      data.split(char)
    end

    def split_and_convert_to_int(data, char)
      data.split(char).map(&:to_i)
    end

    def main
      raw_input = read_input_file
    end
  end
end
