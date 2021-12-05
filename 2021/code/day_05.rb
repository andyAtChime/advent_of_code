require_relative '../../day.rb'

module AdventOfCode
  module Year2021
    class AdventOfCode::Year2021::Day05 < AdventOfCode::Day
      DAY = 5
      YEAR = 2021
      INPUT_PARSER = lambda { |line|
        Line.new(
          *line.split(" -> ")
          .map { |xy| xy.split(',').map(&:to_i) }
        )
      }

      class Line
        def initialize(a, b)
          @x1, @y1 = a
          @x2, @y2 = b
          @dx = @x2 - @x1
          @dy = @y2 - @y1
        end

        def vertical?
          @dx == 0
        end

        def horizontal?
          @dy == 0
        end

        def diagonal?
          @dx.abs == @dy.abs
        end

        def points
          return @points if @points
          @points = []

          dx = @dx / @dx.abs unless @dx == 0
          dy = @dy / @dy.abs unless @dy == 0
          dx ||= 0
          dy ||= 0
          x = @x1
          y = @y1

          while x != @x2 || y != @y2
            @points << [x, y]
            x += dx
            y += dy
          end
          @points << [@x2, @y2]
        end
      end

      class << self
        def run_a
          get_overlap { |line| line.vertical? || line.horizontal? }
        end

        def run_b
          get_overlap { |line| line.vertical? || line.horizontal? || line.diagonal? }
        end

        def get_overlap(&block)
          parsed_input
            .select(&block)
            .map { |line| line.points }
            .flatten(1)
            .group_by { |point| point }
            .values
            .count { |group| group.size > 1 }
        end
      end
    end
  end
end
