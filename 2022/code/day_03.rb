require_relative '../../day.rb'

module AdventOfCode
  module Year2022
    class AdventOfCode::Year2022::Day03 < AdventOfCode::Day
      DAY = 3
      YEAR = 2022
      INPUT_PARSER = lambda { |line| line }
      LOWERCASE = ("a".."z").to_a
      CAPITAL = ("A".."Z").to_a

      class << self
        def letter_value(letter)
          s = (LOWERCASE.index(letter) || 0)
          if s > 0
            s + 1
          else
            CAPITAL.index(letter) + 27
          end
        end

        def shared_letter(arrays)
          a = arrays.map { |a| a.scan(/./) }
          a[1...a.size].reduce(a[0]) { |x, y| x & y }[0]
        end

        def run_a
          splits = parsed_input.map do |line|
            s = line.size
            [line[0...(s / 2)], line[(s / 2)...s]]
          end

          splits.map { |split| letter_value(shared_letter(split)) }.sum
        end

        def run_b
          chunked_input(3).map do |chunk|
            letter_value(shared_letter(chunk))
          end.sum
        end
      end
    end
  end
end
