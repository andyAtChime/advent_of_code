require_relative '../../day.rb'

module AdventOfCode
  module Year2021
    class Day01 < AdventOfCode::Day
      DAY = 1
      YEAR = 2021
      INPUT_PARSER = lambda { |line| line.to_i }

      class << self
        def run_a
          zip_offset(parsed_input, 1).map do |a, b|
            a < b ? 1 : 0
          end.sum
        end

        def run_b
          zip_offset(parsed_input, 3).map do |a, b|
            a < b ? 1 : 0
          end.sum
        end

        def zip_offset(array, depth=1)
          array[0..(-1 - depth)].zip(array[depth..-1])
        end
      end
    end
  end
end

