require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day14 < AdventOfCode::Day
      DAY = 14
      YEAR = 2023
      INPUT_PARSER = lambda { |line| line.split("") }

      class << self
        def split(array)
          array.each_with_object([[]]) do |char, acc|
            if char == "#"
              acc << []
            else
              acc.last << char
            end
          end
        end

        def shake_up(arrays)
          arrays.transpose.map do |line|
            segments = split(line).map {|s| s.sort.reverse}
            walls = ["#"] * (segments.size - 1)
            segments.zip(walls).flatten.compact
          end.transpose
        end

        def rotate_right(arrays)
          arrays.transpose.map(&:reverse)
        end

        def score(arrays)
          arrays.reverse.each_with_index.map do |line, i|
            line.count("O") * (i + 1)
          end.sum
        end

        def spin(arrays)
          4.times { arrays = rotate_right(shake_up(arrays)) }
          arrays
        end

        def run_a
          score(shake_up(parsed_input))
        end

        def run_b
          a = parsed_input
          hash_table = {}
          i, mod, diff = 0, 0, 0
          while true do
            found = hash_table[a]
            if found
              mod = (1000000000 - found) % (i - found)
              break
            end
            hash_table[a] = i
            a = spin(a)
            i += 1
          end

          mod.times { a = spin(a) }
          score(a)
        end
      end
    end
  end
end
