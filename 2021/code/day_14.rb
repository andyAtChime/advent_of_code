require_relative '../../day.rb'

module AdventOfCode
  module Year2021
    class AdventOfCode::Year2021::Day14 < AdventOfCode::Day
      DAY = 14
      YEAR = 2021
      INPUT_PARSER = lambda do |line|
        if line.match("->")
          [line[0], line[1], line[-1]]
        else
          line
        end
      end

      class PairCounter
        attr_reader :pair_counts

        def initialize(state, instructions)
          @pair_counts = {}
          @element_counts = {}
          set_counts(state, instructions)
          @instructions = Hash[instructions.map do |i|
            [i[0] + i[1], i[2]]
          end]
        end

        def set_counts(state, instructions)
          corpus = instructions.flatten
          corpus.repeated_permutation(2).each do |pair|
            @pair_counts[pair.join] = 0
          end
          corpus.each { |c| @element_counts[c] = 0 }

          state.length.times do |i|
            @pair_counts[state[i..(i + 1)]] += 1 if i < state.length - 1
            @element_counts[state[i]] += 1
          end
        end

        def insert
          existing_pairs = {}
          @pair_counts.each do |k, v|
            if v > 0
              existing_pairs[k] = v
            end
          end

          existing_pairs.each do |k, v|
            if @instructions[k]
              inserted = @instructions[k]
              @pair_counts[k] -= v
              @pair_counts[k[0] + inserted] += v
              @pair_counts[inserted + k[1]] += v
              @element_counts[inserted] += v
            end
          end
        end

        def difference
          sorted = @element_counts.keys.sort_by {|c| @element_counts[c]}
          @element_counts[sorted[-1]] - @element_counts[sorted[0]]
        end
      end

      class << self
        def pair_counter(n)
          counter = PairCounter.new(parsed_input[0], parsed_input[2..])
          n.times { counter.insert }
          counter.difference
        end

        def run_a
          pair_counter(10)
        end

        def run_b
          pair_counter(40)
        end
      end
    end
  end
end
