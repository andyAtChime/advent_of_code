require 'set'
require_relative '../../day.rb'

module AdventOfCode
  module Year2022
    class AdventOfCode::Year2022::Day09 < AdventOfCode::Day
      DAY = 9
      YEAR = 2022
      INPUT_PARSER = lambda { |line| [line[0], line.split(" ")[1].to_i] }

      class << self
        class RopeSegment
          attr_accessor :a, :b

          def initialize
            @a = [0, 0]
            @b = [0, 0]
          end

          def update_tail
            dx = (a[0] - b[0])
            dy = (a[1] - b[1])

            if dx.abs == 2
              b[0] += a[0] < b[0] ? -1 : 1
              b[1] += a[1] < b[1] ? -1 : 1 if dy != 0
            elsif dy.abs == 2
              b[1] += a[1] < b[1] ? -1 : 1
              b[0] += a[0] < b[0] ? -1 : 1 if dx != 0
            end
          end

          def follow_instruction(d)
            x = {"U" => [0, 1], "D" => [0, -1], "R" => [1, 0], "L" => [-1, 0]}[d]
            a[0] += x[0]
            a[1] += x[1]
            update_tail
          end
        end

        def snek(s) 
          tail_spots = Set.new([0, 0])
          r = Array.new(s) { RopeSegment.new }

          parsed_input.each do |d, n|
            n.times do
              r[0].follow_instruction(d)

              (1...s).each do |i|
                r[i].a = r[i-1].b.dup
                r[i].update_tail
              end

              tail_spots << r[-1].b
            end
          end

          tail_spots.size - 1
        end

        def run_a
          snek(1)
        end

        def run_b
          snek(9)
        end
      end
    end
  end
end
