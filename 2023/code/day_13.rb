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

        def combo_line(chonk, off_by = 0)
          a = chonk.map { |line| line_to_int(line) }
          (0...a.size).to_a.combination(2).with_object({}) do |(x, y), acc|
            center_line = (x + y + 1) / 2.0
            acc[center_line] ||= []
            acc[center_line] << (a[x] ^ a[y]).to_s(2).count('1')
          end.sum { |k, v| v.sum == off_by && k.to_i == k ? k.to_i : 0 }
        end

        def solve(off_by)
          parsed_input.map do |chonk|
            combo_line(chonk, off_by) * 100 + combo_line(chonk.transpose, off_by)
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
