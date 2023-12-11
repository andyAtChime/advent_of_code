require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day11 < AdventOfCode::Day
      DAY = 11
      YEAR = 2023
      INPUT_PARSER = lambda { |line| line.split('') }

      class << self
        def expanded_rows(rows)
          out = []
          rows.each_with_index do |row, i|
            out << i if row.all? { |r| r == "." }
          end
          out
        end

        def expanded_columns(rows)
          out = []
          rows.transpose.each_with_index do |row, i|
            out << i if row.all? { |r| r == "." }
          end
          out
        end

        def count_within_range(a, b, vals)
          vals.select { |v| ([a, b].min..[a, b].max).include?(v) }.count
        end

        def solve(expansion_factor)
          locations = []
          cols = expanded_columns(parsed_input)
          rows = expanded_rows(parsed_input)

          parsed_input.each_with_index do |row, y|
            row.each_with_index do |col, x|
              locations << [x, y] unless col == "."
            end
          end

          locations.combination(2).map do |a, b|
            x_offset = count_within_range(a[0], b[0], cols)
            y_offset = count_within_range(a[1], b[1], rows)
            (a[0] - b[0]).abs + (a[1] - b[1]).abs + (x_offset + y_offset) * (expansion_factor - 1)
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
