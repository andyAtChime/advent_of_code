require_relative '../../day.rb'

module AdventOfCode
  module Year2022
    class AdventOfCode::Year2022::Day04 < AdventOfCode::Day
      DAY = 4
      YEAR = 2022
      INPUT_PARSER = lambda { |line| line.split(",").map { |x| x.split("-").map(&:to_i) } }

      class << self
        def run_a
          parsed_input.map do |a, b|
            lower = [a[0], b[0]].max
            upper = [a[1], b[1]].min
            inner = [lower, upper]
            (inner == a || inner == b) ? 1 : 0
          end.sum
        end

        def run_b
          parsed_input.map do |a, b|
            lower = [a[0], b[0]].max
            upper = [a[1], b[1]].min
            lower <= upper ? 1 : 0
          end.sum
        end
      end
    end
  end
end
