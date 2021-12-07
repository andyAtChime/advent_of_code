require_relative '../../day.rb'

module AdventOfCode
  module Year2021
    class AdventOfCode::Year2021::Day06 < AdventOfCode::Day
      DAY = 6
      YEAR = 2021
      INPUT_PARSER = lambda { |line| line.split(",").map(&:to_i) }
      @counts = {}

      class << self
        def fish_after_days(days)
          fish_days = [0] * 9
          parsed_input.flatten.each { |n| fish_days[n] += 1 }
          days.times do |i|
            fish_days[(i + 7) % 9] += fish_days[i % 9]
          end
          fish_days.sum
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
