require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day13 < AdventOfCode::Day
      DAY = 13
      YEAR = 2023
      INPUT_PARSER = lambda { |line| line }

      class << self
        def parsed_input
          input_blob.split("\n\n").map do |chonk|
            chonk.split("\n").map { |line| line.split("") }
          end
        end

        def line_to_int(line)
          line.each_with_index.with_object(0).map do |(c, i), acc|
            acc += 2**i if c == '#'
          end.compact.sum
        end

        def ham_self(a, i)
          a[i...(i * 2)].zip(a[0...i].reverse).map do |x, y|
            (x ^ y).to_s(2).count('1')
          end.sum
        end

        def chonk_line(chonk, off_by = 0)
          a = chonk.map { |line| line_to_int(line) }
          1.upto(a.size / 2).map do |i|
            if ham_self(a, i) == off_by
              i
            elsif ham_self(a.reverse, i) == off_by
              a.size - i
            end
          end.compact.max || 0
        end

        def solve(off_by)
          parsed_input.map do |chonk|
            chonk_line(chonk, off_by) * 100 + chonk_line(chonk.transpose, off_by)
          end.flatten.sum
        end

        def run_a
          solve(0)
        end

        def run_b
          solve(1)
        end
      end
    end
  end
end
