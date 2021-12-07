require_relative '../../day.rb'

module AdventOfCode
  module Year2021
    class AdventOfCode::Year2021::Day07 < AdventOfCode::Day
      DAY = 7
      YEAR = 2021
      INPUT_PARSER = lambda { |line| line.split(",").map(&:to_i) }

      class << self
        def numbers
          @numbers = parsed_input[0]
        end

        def optimal_fuel(&block)
          (numbers.min..numbers.max).map(&block).min
        end

        def run_a
          optimal_fuel { |i| numbers.map { |n| (n - i).abs }.sum }
        end

        def run_b
          optimal_fuel { |i| numbers.map { |n| (1..((n - i).abs)).sum }.sum }
        end
      end
    end
  end
end
