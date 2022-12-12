require_relative '../../day.rb'

module AdventOfCode
  module Year2022
    class AdventOfCode::Year2022::Day12 < AdventOfCode::Day
      DAY = 12
      YEAR = 2022
      INPUT_PARSER = lambda { |line| line }

      class << self
        def height_from_letter(letter)
          if letter == "S"
            0
          elsif letter == "E"
            27
          else
            letter.ord - 96
          end
        end

        def search(target)
          distances = {}
          heights = {}

          e = nil
          parsed_input.each_with_index do |line, i|
            line.scan(/./).each_with_index do |letter, j|
              h = height_from_letter(letter)
              heights[[i,j]] = h
              e = [i,j] if h == 27
            end
          end

          distances[e] = 0
          next_cycle = [e]

          offsets = [[-1, 0], [1, 0], [0, 1], [0, -1]]

          while true
            current_cycle = next_cycle
            next_cycle = []
            return if current_cycle == []

            current_cycle.each do |a, b|
              d = distances[[a,b]]
              offsets.each do |x, y|
                ax = a + x
                by = b + y
                if !distances[[ax, by]] && heights[[ax, by]]
                  if heights[[ax, by]] - heights[[a,b]] >= -1
                    distances[[ax, by]] = d + 1
                    next_cycle << [ax, by]
                    return d + 1 if heights[[ax,by]] == target
                  end
                end
              end
            end
          end
        end

        def run_a
          search(0)
        end

        def run_b
          search(1)
        end
      end
    end
  end
end
