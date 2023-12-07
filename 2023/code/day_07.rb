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
      }
      HANDS = [:high_card, :pair, :two_pair, :three, :full, :four, :five]

      class Hand
        attr_reader :cards, :bid, :version

        class << self
          def from_line(line, version)
            c, bid = line.split(" ")
            cards = c.split("")
            Hand.new(cards, bid.to_i, version)
          end
        end

        def initialize(cards, bid, version)
          @cards = cards
          @bid = bid
          @version = version
        end

        def <=>(other)
          puts "cards: #{cards}, other.cards: #{other.cards}" unless kind
          if HANDS.index(kind) == HANDS.index(other.kind)
            0.upto(4) do |i|
              next if CARDS[version].index(cards[i]) == CARDS[version].index(other.cards[i])
              return CARDS[version].index(cards[i]) <=> CARDS[version].index(other.cards[i])
            end
          else
            return HANDS.index(kind) <=> HANDS.index(other.kind)
          end
        end

        def kind
          version == :v1 ? kind_v1 : kind_v2
        end

        def kind_v1
          # group cards by count of each card
          counts = @cards.group_by { |c| @cards.count(c) }
          if counts.keys.include?(3) && counts.keys.include?(2)
            return :full
          elsif counts[2]&.uniq&.length == 2
            return :two_pair
          else
            [:high_card, :pair, :three, :four, :five][(counts.keys.max || 0) - 1]
          end
        end

        def kind_v2
          counts = (@cards - ["J"]).group_by { |c| @cards.count(c) }
          js = @cards.count("J")

          if counts.keys.include?(3) && counts.keys.include?(2)
            return :full
          elsif counts[2]&.uniq&.length == 2
            return js == 1 ? :full : :two_pair
          else
            [:high_card, :pair, :three, :four, :five][(counts.keys.max || 0) + js - 1]
          end
        end
      end

      class << self
        def run_a
          input_lines.map { |l| Hand.from_line(l, :v1) }.sort.map.with_index do |hand, i|
            hand.bid * (i + 1)
          end.sum
        end

        def run_b
          input_lines.map { |l| Hand.from_line(l, :v2) }.sort.map.with_index do |hand, i|
            hand.bid * (i + 1)
          end.sum
        end
      end
    end
  end
end
