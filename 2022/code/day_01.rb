require_relative '../../day.rb'

module AdventOfCode
  module Year2022
    class AdventOfCode::Year2022::Day01 < AdventOfCode::Day
      DAY = 1
      YEAR = 2022
      INPUT_PARSER = lambda { |line| line }

      class << self
        def sums
          current = 0
          parsed_input.each_with_object([]) do |line, sums|
            if line.length > 0
              current += line.to_i
            else
              sums << current
              current = 0
            end
          end
        end

        def run_a
          sums.max
        end

        def run_b
          sums.sort.reverse[0..2].sum
        end
      end
    end
  end
end
