require_relative '../../day.rb'

module AdventOfCode
  module Year2021
    class AdventOfCode::Year2021::Day06 < AdventOfCode::Day
      DAY = 6
      YEAR = 2021
      INPUT_PARSER = lambda { |line| line.split(",").map(&:to_i) }
      @counts = {}

      class << self
        def get_offspring_count(count, days)
          return @counts[[count, days]] if @counts[[count, days]]

          a = count
          total = 1
          days.times do |i|
            a -= 1
            if a < 0
              a %= 7
              total += get_offspring_count(8, days - i - 1)
            end
          end

          @counts[[count, days]] = total
        end

        def fish_after_days(days)
          numbers = parsed_input[0]
          numbers.map { |n| get_offspring_count(n, days) }.sum
        end

        def run_a
          fish_after_days(80)
        end

        def run_b
          fish_after_days(256)
        end
      end
    end
  end
end
