require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day01 < AdventOfCode::Day
      DAY = 1
      YEAR = 2023
      INPUT_PARSER = lambda { |line| line }

      class << self
        def run_a
          input_lines.map do |line|
            a = line.gsub(/\D/, '')
            (a[0] + a[-1]).to_i
          end.sum
        end

        def run_b
          input_lines.map do |line|
            (first_digit(line) + last_digit(line)).to_i
          end.sum
        end

        def first_digit(line)
          scanner = /#{findable.join('|')}/
          results = string_to_digit(line.scan(scanner)[0])
        end

        def last_digit(line)
          scanner = /#{findable.map(&:reverse).join('|')}/
          results = string_to_digit(line.reverse.scan(scanner)[0].reverse)
        end

        def findable_strings
          @findable_strings ||= ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
        end

        def findable_digits
          @findable_digits ||= ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        end

        def string_to_digit(s)
          findable_digits.include?(s) ? s : (findable_strings.index(s) + 1).to_s
        end

        def findable
          @findable ||= findable_strings + findable_digits
        end
      end
    end
  end
end
