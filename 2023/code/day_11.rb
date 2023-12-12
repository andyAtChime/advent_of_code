require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day11 < AdventOfCode::Day
      DAY = 11
      YEAR = 2023
      INPUT_PARSER = lambda { |line| line.split('') }

      class << self
        def counts(a, b, vals)
          vals.select { |v| ([a, b].min..[a, b].max).include?(v) }.count
        end

        def raw_dist(a, b)
          (a[0] - b[0]).abs + (a[1] - b[1]).abs
        end

        def solve(expansion_factor)
          locations = []
          rows = (0..parsed_input.size).to_a
          cols = (0..parsed_input[0].size).to_a

          parsed_input.each_with_index do |row, y|
            row.each_with_index do |val, x|
              next unless val == "#"
              rows -= [y]
              cols -= [x]
              locations << [x, y]
            end
          end

          locations.combination(2).map do |a, b|
            raw_dist(a, b) + (counts(a[0], b[0], cols) + counts(a[1], b[1], rows)) * (expansion_factor - 1)
          end.sum
        end

        def run_a
          solve(2)
        end

        def run_b
          solve(1000000)
        end
      end
    end
  end
end
