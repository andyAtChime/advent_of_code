require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day04 < AdventOfCode::Day
      DAY = 4
      YEAR = 2023
      INPUT_PARSER = lambda { |line| Card.from_line(line) }

      class Card
        attr_reader :card_no, :winning_numbers, :my_numbers

        class << self
          def from_line(line)
            card_no, front, back = line.split(/: | \| /).map { |s| s.scan(/\d+/).map(&:to_i) }
            card_no = card_no.first
            new(card_no, front, back)
          end
        end

        def initialize(card_no, winning_numbers, my_numbers)
          @card_no = card_no
          @winning_numbers = winning_numbers
          @my_numbers = my_numbers
        end

        def match_count
          @match_count ||= (my_numbers & winning_numbers).length
        end

        def score
          match_count > 0 ? 2 ** (match_count - 1) : 0
        end
      end

      class << self
        def run_a
          parsed_input.map(&:score).sum
        end

        def run_b
          counts = Hash.new(1)

          parsed_input.map do |card|
            card.match_count.times { |i| counts[card.card_no + i + 1] += counts[card.card_no] }
            counts[card.card_no]
          end.sum
        end
      end
    end
  end
end
