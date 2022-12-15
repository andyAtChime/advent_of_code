require_relative '../../day.rb'

module AdventOfCode
  module Year2022
    class AdventOfCode::Year2022::Day15 < AdventOfCode::Day
      DAY = 15
      YEAR = 2022
      INPUT_PARSER = lambda do |line|
        s = line.split("=")
        xs = s[1].split(',')[0].to_i
        ys = s[2].split(':')[0].to_i
        xb = s[3].split(',')[0].to_i
        yb = s[4].to_i
        [[xs, ys], [xb, yb]]
      end

      class << self
        def distance(a, b)
          a.zip(b).sum { |i, j| (i-j).abs }
        end

        def run_a
          a = parsed_input.map do |sensor, beacon|
            d = distance(sensor, beacon)
            dy = (2000000 - sensor[1]).abs
            dx = d - dy
            [sensor[0] - dx, sensor[0] + dx] if dx > 0
          end.compact

          a = a.sort
          all_ranges = []
          current_range = nil
          a.each_with_index do |r, i|
            current_range = r if current_range.nil?
            if i < a.size - 1 && current_range[1] >= a[i+1][0]
              current_range[1] = [current_range[1], a[i+1][1]].max
            else
              all_ranges << current_range
              current_range = nil
            end
          end
          all_ranges[0][1] - all_ranges[0][0]
        end

        def run_b
          a = parsed_input.map do |sensor, beacon|
            d = distance(sensor, beacon)
            dy = (2973564 - sensor[1]).abs
            dx = d - dy
            [sensor[0] - dx, sensor[0] + dx] if dx > 0
          end.compact

          a = a.sort
          all_ranges = []
          current_range = nil
          a.each_with_index do |r, i|
            current_range = r if current_range.nil?
            if i < a.size - 1 && current_range[1] >= a[i+1][0]
              current_range[1] = [current_range[1], a[i+1][1]].max
            else
              all_ranges << current_range
              current_range = nil
            end
          end
          pp (all_ranges[0][1] + 1) * 4000000 + 2973564
        end
      end
    end
  end
end
