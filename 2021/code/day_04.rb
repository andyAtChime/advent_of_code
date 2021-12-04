require_relative '../../day.rb'

module AdventOfCode
  module Year2021
    class AdventOfCode::Year2021::Day04 < AdventOfCode::Day
      DAY = 4
      YEAR = 2021
      INPUT_PARSER = lambda do |line|
        line.gsub(/^\s+/, "").split(/\s+/)
      end

      class Bingo
        attr_reader :guesses, :lines

        def initialize(lines, numbers)
          @lines = lines
          @guesses = 0
          feed(numbers)
        end

        def <=>(other)
          guesses <=> other.guesses
        end

        def sum
          @lines.map { |line| line.map(&:to_i).sum }.sum
        end

        def feed(numbers)
          while !check && @guesses < numbers.length
            add(numbers[@guesses])
            @guesses += 1 unless check
          end
        end

        def check
          check_rows || check_columns
        end

        def add(number)
          @lines.each_with_index do |row, i|
            row.each_with_index do |column, j|
              if number == column
                @lines[i][j] = ""
              end
            end
          end
        end

        def check_rows
          a = @lines.any? do |line|
            line.all? { |number| number == "" }
          end
        end

        def check_columns
          a = @lines.transpose.any? do |line|
            line.all? { |number| number == "" }
          end
        end
      end

      class << self
        def numbers
          @numbers ||= parsed_input[0][0].split(",")
        end

        def all_boxes
          boxes = parsed_input[1..-1]
            .each_slice(6)
            .map { |b| Bingo.new(b[1..-1], numbers) }
        end

        def box_to_answer(box)
          box.sum * numbers[box.guesses].to_i
        end

        def find_guesses_by(func)
          box_to_answer(all_boxes.send(func))
        end

        def run_a
          find_guesses_by(:min)
        end

        def run_b
          find_guesses_by(:max)
        end
      end
    end
  end
end
