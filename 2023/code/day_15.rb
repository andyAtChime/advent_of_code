require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day15 < AdventOfCode::Day
      DAY = 15
      YEAR = 2023
      INPUT_PARSER = lambda { |line| line }

      class << self
        def hash(str)
          str.chars.reduce(0) { |acc, c| (((acc + c.ord) * 17) % 256) }
        end

        def run_a
          input_blob.chomp.split(",").map { |n| hash(n) }.sum
        end

        def run_b
          boxes = Array.new(256) { [] }
          input_blob.chomp.split(",").each_with_index do |n, i|
            if n.match("=")
              a, b = n.split("=")
              h = hash(a)
              index = boxes[h].map(&:first).index(a)
              index ? boxes[h][index] = [a, b] : boxes[h] << [a, b]
            else
              a = n.split("-").first
              h = hash(a)
              boxes[h] = boxes[h].reject { |label, value| label == a }
            end
          end

          boxes.each_with_index.map do |box, i|
            box.each_with_index.map do |(_, value), j|
              (i + 1) * (j + 1) * value.to_i
            end
          end.flatten.sum
        end
      end
    end
  end
end
