require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day18 < AdventOfCode::Day
      DAY = 18
      YEAR = 2023
      INPUT_PARSER = lambda { |line| line.split(" ") }
      DIRS = {"R" => [1, 0], "L" => [-1, 0], "U" => [0, -1], "D" => [0, 1]}
      HEX_DIRS = {"0" => "R", "1" => "D", "2" => "L", "3" => "U"}

      Parser1 = lambda do |dir, distance, _|
        [dir, distance.to_i]
      end

      Parser2 = lambda do |_, _, hex|
        [HEX_DIRS[hex[-2]], hex[2..6].to_i(16)]
      end

      Vertex = Struct.new(:x, :y) do
        def next(dir, distance)
          self.class.new(x + DIRS[dir].first * distance, y + DIRS[dir].last * distance)
        end
      end

      class << self
        def vertices(instructions)
          instructions.reduce([Vertex.new(0, 0)]) do |acc, (dir, dist)|
            acc << acc.last.next(dir, dist)
          end
        end

        def fill_amount(parser)
          instructions = parsed_input.map { |args| parser.call(*args) }
          coords = vertices(instructions)[0...-1]

          lines = []
          groupings = coords.sort_by { |v| [v.y, v.x] }.group_by { |v| v.y }
          groupings.map do |row, group|
            group.each { |v| lines.include?(v.x) ? lines.delete(v.x) : lines << v.x }
            [row, lines.sort!.each_slice(2).map { |a, b| b - a }.sum]
          end.each_cons(2).map do |(row, thickness), (next_row, _)|
            thickness * (next_row - row)
          end.sum + instructions.map(&:last).sum / 2 + 1
        end

        def run_a
          fill_amount(Parser1)
        end

        def run_b
          fill_amount(Parser2)
        end
      end
    end
  end
end
