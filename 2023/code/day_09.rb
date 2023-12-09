require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day09 < AdventOfCode::Day
      DAY = 9
      YEAR = 2023
      INPUT_PARSER = lambda { |line| line.scan(/\S+/).map(&:to_i) }

      class << self
        def get_diffs(ints)
          zipped = ints[0...-1].zip(ints[1..-1])
          zipped.map do |a, b|
            b - a
          end
        end

        def run_a
          parsed_input.map do |line|
            ints = line
            i = line[-1]

            until ints.all?(&:zero?)
              ints = get_diffs(ints)
              i += ints[-1]
            end
            i
          end.sum
        end

        def run_b
          parsed_input.map do |line|
            diff_lists = [line]
            until diff_lists[-1].all?(&:zero?)
              diff_lists << get_diffs(diff_lists[-1])
            end
            i = 0
            diff_lists[0].push(0)
            new = 0
            diff_lists.reverse[1..].each do |diff_list|
              new = diff_list[0] - new
            end
            new
          end.sum
        end
      end
    end
  end
end
