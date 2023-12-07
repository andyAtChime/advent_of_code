require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day07 < AdventOfCode::Day
      DAY = 7
      YEAR = 2023
      INPUT_PARSER = lambda { |line| line }
      CARDS = {
        v1: ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"],
        v2: ["J", "2", "3", "4", "5", "6", "7", "8", "9", "T", "Q", "K", "A"],
      }.freeze
      HANDS = [:high_card, :pair, :two_pair, :three, :full, :four, :five].freeze

      class Hand
        attr_reader :cards, :bid, :version

        class << self
          def from_line(line, version)
            cards, bid = line.split(" ")
            Hand.new(cards.split(""), bid.to_i, version)
          end
        end

        def initialize(cards, bid, version)
          @cards = cards
          @bid = bid
          @version = version
        end

        def card_index(i)
          CARDS[version].index(cards[i])
        end

        def <=>(other)
          if HANDS.index(kind) == HANDS.index(other.kind)
            0.upto(4) do |i|
              next if card_index(i) == other.card_index(i)
              return card_index(i) <=> other.card_index(i)
            end
          else
            return HANDS.index(kind) <=> HANDS.index(other.kind)
          end
        end

        def kind
          if counts.keys.include?(3) && counts.keys.include?(2)
            return :full
          elsif counts[2]&.uniq&.length == 2
            return wilds == 1 ? :full : :two_pair
          else
            [:high_card, :pair, :three, :four, :five][(counts.keys.max || 0) + wilds - 1]
          end
        end

        def counts
          @counts ||= {
            v1: @cards,
            v2: @cards.reject { |c| c == "J" }
          }[version].group_by { |c| @cards.count(c) }
        end

        def wilds
          @wilds ||= {v1: 0, v2: @cards.count("J")}[version]
        end
      end

      class << self
        def run(version)
          input_lines.map { |l| Hand.from_line(l, version) }.sort.map.with_index do |hand, i|
            hand.bid * (i + 1)
          end.sum
        end

        def run_a
          run(:v1)
        end

        def run_b
          run(:v2)
        end
      end
    end
  end
end
