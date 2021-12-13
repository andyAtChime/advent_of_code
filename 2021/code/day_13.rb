require_relative '../../day.rb'

module AdventOfCode
  module Year2021
    class AdventOfCode::Year2021::Day13 < AdventOfCode::Day
      DAY = 13
      YEAR = 2021
      INPUT_PARSER = lambda do |line|
        if line.match?("fold along ")
          [0, line[11..]]
        elsif line.length > 1
          [1, line.split(',').map(&:to_i)]
        else
          [2, nil]
        end
      end

      class << self
        def folds
          parsed_input
            .select { |x| x[0] == 0 }
            .map { |x| x[1].split("=") }
            .map { |a, b| [a, b.to_i] }
        end

        def points
          parsed_input.select { |x| x[0] == 1 }.map { |x| x[1] }
        end

        class Folder
          def initialize(folds, points)
            @folds = folds
            @points = points
          end

          def size
            @points.uniq.size
          end

          def fold_all!
            @folds.size.times { fold_points! }
          end

          def fold_points!
            axis, line = @folds.shift
            index = axis == "x" ? 0 : 1
            @points.each_with_index do |point, i|
              if point[index] > line
                @points[i][index] = 2 * line - point[index]
              end
            end
          end

          def to_s
            string = ""
            (0..(@points.uniq.map { |x| x[1] }.max)).each do |x|
              (0..(@points.uniq.map { |x| x[0] }.max)).each do |y|
                string += @points.include?([y, x]) ? "XX" : "  "
              end
              string += "\n"
            end
            string
          end
        end

        def run_a
          folder = Folder.new(folds, points)
          folder.fold_points!
          folder.size
        end

        def run_b
          folder = Folder.new(folds, points)
          folder.fold_all!
          folder.to_s
        end
      end
    end
  end
end
