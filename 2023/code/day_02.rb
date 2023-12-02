require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day02 < AdventOfCode::Day
      DAY = 2
      YEAR = 2023
      INPUT_PARSER = lambda { |line| line }

      class Game
        attr_reader :id, :draws

        class << self
          def from_string(str)
            id, draws = str.split(": ")
            id = id.scan(/\d+/).first.to_i
            draws = draws.split("; ").map { |draw| Draw.from_string(draw) }
            new(id: id, draws: draws)
          end
        end

        def initialize(id:, draws:)
          @id = id
          @draws = draws
        end

        def power
          draws.map(&:red).max * draws.map(&:green).max * draws.map(&:blue).max
        end

        class Draw
          attr_reader :red, :green, :blue

          class << self
            def from_string(str)
              vals = str.split(", ")
              new(
                vals.map { |val| val.split(" ").reverse }
                .map { |val| [val[0].to_sym, val[1].to_i] }
                .to_h
              )
            end
          end

          def initialize(red: 0, green: 0, blue: 0)
            @red = red.to_i
            @green = green.to_i
            @blue = blue.to_i
          end
        end
      end

      class << self
        def over_limit(draw)
          draw.red > 12 || draw.green > 13 || draw.blue > 14
        end

        def run_a
          input_lines.map do |line|
            g = Game.from_string(line)
            g.draws.any? { |draw| over_limit(draw) } ? 0 : g.id
          end.sum
        end

        def run_b
          input_lines.map do |line|
            Game.from_string(line).power
          end.sum
        end
      end
    end
  end
end
