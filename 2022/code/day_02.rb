require_relative '../../day.rb'

module AdventOfCode
  module Year2022
    class AdventOfCode::Year2022::Day02 < AdventOfCode::Day
      DAY = 2
      YEAR = 2022

      OPPONENT = ["A", "B", "C"]
      ME = ["X", "Y", "Z"]

      INPUT_PARSER = lambda do |line|
        [OPPONENT.index(line[0]), ME.index(line[2])]
      end

      class << self
        def score(opp, me)
          offset = (me - opp + 1) % 3
          thrown_score = me + 1
          offset * 3 + thrown_score
        end

        def run_a
          parsed_input.map do |opp, me|
            score(opp, me)
          end.sum
        end

        def run_b
          parsed_input.map do |opp, me|
            real_me = (opp + me - 1) % 3
            (real_me + 1) + (me * 3) # equivalent to score(opp, real_me)
          end.sum
        end
      end
    end
  end
end
