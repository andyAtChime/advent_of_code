require_relative '../../day.rb'

module AdventOfCode
  module Year2022
    class AdventOfCode::Year2022::Day08 < AdventOfCode::Day
      DAY = 8
      YEAR = 2022
      INPUT_PARSER = lambda { |line| line.chars.map(&:to_i) }

      class << self
        def transposed
          @transposed ||= parsed_input.transpose
        end

        def edge_visible(line)
          current_max = -1
          line.map do |tree|
            (tree > current_max).tap do |b|
              current_max = tree if b
            end
          end
        end

        def distance_back(line)
          map_back = [0] * 10
          line.map do |tree|
            score = map_back[(tree..9)].min
            (0..tree).each {|i| map_back[i] = 1}
            ((1 + tree)..9).each {|i| map_back[i] += 1}
            score
          end
        end

        def operated_directions(&block)
          [
            parsed_input.map{ |l| block.call(l) },
            parsed_input.map{ |l| block.call(l.reverse).reverse },
            transposed.map{ |l| block.call(l) }.transpose,
            transposed.map{ |l| block.call(l.reverse).reverse }.transpose,
          ]
        end

        def run_a
          trees = 0
          transformed = operated_directions {|l| edge_visible(l) }

          parsed_input.each_with_index do |row, i|
            row.each_index do |j|
              trees += 1 if transformed.reduce(false) {|a, b| a || b[i][j]}
            end
          end

          trees
        end

        def run_b
          best = 0
          transformed = operated_directions { |l| distance_back(l) }

          parsed_input.each_with_index do |row, i|
            row.each_index do |j|
              score = transformed.reduce(1) {|a, b| a * b[i][j]}
              best = score if score > best
            end
          end

          best
        end
      end
    end
  end
end
