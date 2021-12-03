require_relative '../../day.rb'

module AdventOfCode
  module Year2021
    class AdventOfCode::Year2021::Day03 < AdventOfCode::Day
      DAY = 3
      YEAR = 2021
      INPUT_PARSER = lambda { |line| line.split("").map(&:to_i) }

      class << self
        def run_a
          len = parsed_input[0].length
          count = parsed_input.length
          array = [0.0] * len

          parsed_input.each do |line|
            len.times do |i|
              array[i] += line[i]
            end
          end

          most_common = array.map { |i| i / count > 0.5 ? 1 : 0 }
          least_common = array.map { |i| i / count < 0.5 ? 1 : 0 }
          int_array_to_binary(most_common) * int_array_to_binary(least_common)
        end

        def run_b
          co2 = find_bits(false)
          o2 = find_bits(true)
          co2 * o2
        end

        def find_bits(most=true)
          a, b = most ? ["0", "1"] : ["1", "0"]
          len = parsed_input[0].length
          count = parsed_input.length

          binary = ""
          len.times do |i|
            hits = input_lines.select {|line| line.start_with?(binary)}
            count = hits.length
            if count == 1
              binary = hits[0]
              break
            end
            one_hits = hits.select { |h| h[i] == "1" }
            binary += one_hits.length / count.to_f >= 0.5 ? a : b
          end

          int_array_to_binary(binary.split(""))
        end

        def int_array_to_binary(array)
          array.map(&:to_s).join.to_i(2)
        end
      end
    end
  end
end
