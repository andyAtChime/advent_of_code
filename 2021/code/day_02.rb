require_relative '../../day.rb'

module AdventOfCode
  module Year2021
    class Day02 < AdventOfCode::Day
      DAY = 2
      YEAR = 2021
      INPUT_PARSER = lambda do |line|
        a, b = line.split(" ")
        [a, b.to_i]
      end

      class << self
        def run_a
          depth = 0
          horizontal = 0

          parsed_input.each do |direction, distance|
            case direction
            when "forward"
              horizontal += distance
            when "up"
              depth -= distance
            when "down"
              depth += distance
            end
            puts depth, horizontal
          end

          depth * horizontal
        end

        def run_b
          depth = 0
          horizontal = 0
          aim = 0

          parsed_input.each do |direction, distance|
            case direction
            when "forward"
              horizontal += distance
              depth += distance * aim
            when "up"
              aim -= distance
            when "down"
              aim += distance
            end
          end

          depth * horizontal
        end
      end
    end
  end
end
