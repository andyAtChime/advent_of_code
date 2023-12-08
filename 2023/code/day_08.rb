require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day08 < AdventOfCode::Day
      DAY = 8
      YEAR = 2023
      INPUT_PARSER = lambda { |line| line }

      class << self
        def instructions
          input_lines[2...input_lines.length].each_with_object({}) do |line, instructions|
            c, l, r = line.match(/(\w*) = \((\w*), (\w*)\)/).captures
            instructions[c] = {"L" => l, "R" => r}
          end
        end

        def directions
          directions = input_lines.first.split("")
        end

        def run_a
          inst = instructions
          dir = directions
          i = 0
          current = "AAA"
          while current != "ZZZ"
            current = inst[current][dir[i % dir.length]]
            i += 1
          end
          return i
        end

        def run_b
          inst = instructions
          dir = directions
          starts = instructions.keys.select { |k| k[-1] == "A" }
          starts.each_with_object([]) do |start, mods|
            i = 0
            current = start
            while current[-1] != "Z"
              current = inst[current][dir[i % dir.length]]
              i += 1
            end
            mods << i
          end.uniq.reduce(:lcm)
        end
      end
    end
  end
end
