require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day07 < AdventOfCode::Day
      DAY = 7
      YEAR = 2023
      INPUT_PARSER = lambda { |line| line }
      CARDS = {
        v1: ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"].reverse,
        v2: ["A", "K", "Q", "T", "9", "8", "7", "6", "5", "4", "3", "2", "J"].reverse,
      }
      HANDS = [:five, :four, :full, :three, :two_pair, :pair, :high_card].reverse

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
          if counts.keys.include?(5)
            return :five
          elsif counts.keys.include?(4)
            return :four
          elsif counts.keys.include?(3) && counts.keys.include?(2)
            return :full
          elsif counts.keys.include?(3)
            return :three
          elsif counts[2]&.uniq&.length == 2
            return :two_pair
          elsif counts.keys.count(2) == 1
            return :pair
          else
            return :high_card
          end
        end

        def kind_v2
          counts = (@cards - ["J"]).group_by { |c| @cards.count(c) }
          js = @cards.count("J")

          if counts.keys.include?(5)
            return :five
          elsif counts.keys.include?(4)
            return js == 1 ? :five : :four
          elsif counts.keys.include?(3) && counts.keys.include?(2)
            return :full
          elsif counts.keys.include?(3)
            case js
            when 0
              return :three
            when 1
              return :four
            when 2
              return :five
            end
          elsif counts[2]&.uniq&.length == 2
            return js == 1 ? :full : :two_pair
          elsif counts.keys.count(2) == 1
            case js
            when 0
              return :pair
            when 1
              return :three
            when 2
              return :four
            when 3
              return :five
            end
          else
            case js
            when 0
              return :high_card
            when 1
              return :pair
            when 2
              return :three
            when 3
              return :four
            when 4
              return :five
            when 5
              return :five
            end
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
