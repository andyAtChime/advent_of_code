require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day09 < AdventOfCode::Day
      DAY = 9
      YEAR = 2023
      INPUT_PARSER = lambda { |line| line.scan(/\S+/).map(&:to_i) }

      class << self
        def get_diffs(ints)
          ints[0...-1].zip(ints[1..-1]).map { |a, b| b - a }
        end

        def reduce_diffs(ints, &block)
          [ints].tap do |diffs|
            diffs << get_diffs(diffs[-1]) until diffs[-1].all?(&:zero?)
          end.map(&block)
        end

        def run_a
          parsed_input.map { |ints| reduce_diffs(ints, &:last) }.flatten.sum
        end

        def run_b
          parsed_input.map do |ints|
            reduce_diffs(ints, &:first).reverse.reduce(0) { |a, b| b - a }
          end.sum
        end
      end
    end
  end
end
