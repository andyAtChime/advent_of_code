require_relative '../../day.rb'

module AdventOfCode
  module Year2021
    class AdventOfCode::Year2021::Day21 < AdventOfCode::Day
      DAY = 21
      YEAR = 2021
      INPUT_PARSER = lambda { |line| line[-1].to_i }

      class DeterministicDice
        attr_reader :rolls

        def initialize
          @value = 1
          @cache = {}
          @rolls = 0
        end

        def roll
          @rolls += 3
          v = roll_value
          increment
          v
        end

        def value_plus(i)
          (i + @value - 1) % 10 + 1
        end

        def increment
          @value = value_plus(3)
        end

        def roll_value
          @cache[@value % 10] ||= (0...3).map {|x| value_plus(x)}.sum % 10
        end
      end

      class Player
        attr_reader :score

        def initialize(starting, dice)
          @score = 0
          @space = starting
          @dice = dice
        end

        def space_plus(i)
          (i + @space - 1) % 10 + 1
        end

        def roll
          @space = space_plus(@dice.roll)
          @score += @space
        end
      end

      class QuantumDice
        attr_reader :possibilities, :victories

        def initialize(starts)
          @possibilities = Array.new(2) { blank_possibilities }
          @victories = [0, 0]
          @possibilities[0][starts[0] - 1][starts[1] - 1][0][0] = 1
        end

        def blank_possibilities
          Array.new(10) { Array.new(10) { Array.new(21) { Array.new(21) { 0 } } } }
        end

        def get_counts(space_1, space_2, score_1, score_2)
          @possibilities[0][space_1][space_2][score_1][score_2]
        end

        def add_counts(space_1, space_2, score_1, score_2, score)
          @possibilities[1][space_1][space_2][score_1][score_2] += score
        end

        def player_1_turn
          @possibilities[0].each_with_index do |player_1, a|
            player_1.each_with_index do |player_2, b|
              player_2.each_with_index do |score_1, c|
                score_1.each_with_index do |existing_count, d|
                  next if existing_count == 0
                  turn_outcomes.each do |outcome, new_count|
                    dest = (a + outcome) % 10
                    new_score = dest + 1 + c
                    if new_score >= 21
                      @victories[0] += existing_count * new_count
                    else
                      add_counts(dest, b, new_score, d, existing_count * new_count)
                    end
                  end
                end
              end
            end
          end
          rotate_possibilities
        end

        def player_2_turn
          @possibilities[0].each_with_index do |player_1, a|
            player_1.each_with_index do |player_2, b|
              player_2.each_with_index do |score_1, c|
                score_1.each_with_index do |existing_count, d|
                  next if existing_count == 0
                  turn_outcomes.each do |outcome, new_count|
                    dest = (b + outcome) % 10
                    new_score = dest + 1 + d
                    if new_score >= 21
                      @victories[1] += existing_count * new_count
                    else
                      add_counts(a, dest, c, new_score, existing_count * new_count)
                    end
                  end
                end
              end
            end
          end
          rotate_possibilities
        end

        def rotate_possibilities
          @possibilities = [@possibilities[1], blank_possibilities]
        end

        def turn_outcomes
          { 3 => 1, 4 => 3, 5 => 6, 6 => 7, 7 => 6, 8 => 3, 9 => 1 }
        end
      end

      class << self
        def run_game(starts)
          dice = DeterministicDice.new
          players = starts.map { |p| Player.new(p, dice) }
          i = 0
          loop do
            if players[i].roll >= 1000
              return players[(i + 1) % 2].score * dice.rolls
            end
            i += 1
            i %= 2
          end
        end

        def run_a
          run_game(parsed_input)
        end

        def run_b
          g = QuantumDice.new(parsed_input)
          21.times do
            g.player_1_turn
            g.player_2_turn
          end
          g.victories.max
        end
      end
    end
  end
end
