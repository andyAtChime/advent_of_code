require_relative '../../day.rb'

module AdventOfCode
  module Year2022
    class AdventOfCode::Year2022::Day01 < AdventOfCode::Day
      DAY = 1
      YEAR = 2022
      INPUT_PARSER = lambda { |line| line.to_i }

      class << self
        def sums
          chunked_input(0).map(&:sum)
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
