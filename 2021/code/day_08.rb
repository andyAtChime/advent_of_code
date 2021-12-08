require_relative '../../day.rb'
require 'set'

module AdventOfCode
  module Year2021
    class AdventOfCode::Year2021::Day08 < AdventOfCode::Day
      DAY = 8
      YEAR = 2021
      INPUT_PARSER = lambda { |line| Line.new(line) }

      class Line
        attr_reader :inputs, :outputs
        attr_accessor :key

        def initialize(line)
          raw_inputs, raw_outputs = line.split(" | ")
          @inputs = raw_inputs.split(" ").map { |d| Set[*d.split("")] }
          @outputs = raw_outputs.split(" ").map { |d| Set[*d.split("")] }
          @key = {}
          deduce_digits
        end

        def from_remaining(&block)
          inputs.reject { |i| key.values.include?(i) }.find(&block)
        end

        def deduce_digits
          key[1] = from_remaining { |d| d.length == 2 }
          key[4] = from_remaining { |d| d.length == 4 }
          key[7] = from_remaining { |d| d.length == 3 }
          key[8] = from_remaining { |d| d.length == 7 }
          key[6] = from_remaining { |d| (key[8] - key[7]).subset?(d) }
          key[9] = from_remaining { |d| key[4].subset?(d) }
          key[0] = from_remaining { |d| d.length == 6 }
          key[3] = from_remaining { |d| d.superset?(key[7]) }
          key[5] = from_remaining { |d| (key[6] & key[9]) == d }
          key[2] = from_remaining { |d| true }
        end

        def output_integer
          outputs.map {|o| key.invert[o]}.join.to_i
        end
      end

      class << self
        def run_a
          parsed_input.map do |line|
            line.outputs.count { |digit| [2, 3, 4, 7].include?(digit.length) }
          end.sum
        end

        def run_b
          parsed_input.map { |line| line.output_integer }.sum
        end
      end
    end
  end
end
