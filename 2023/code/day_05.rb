require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day05 < AdventOfCode::Day
      DAY = 5
      YEAR = 2023
      INPUT_PARSER = lambda { |line| line }

      class << self
        def input_transformer(array_layer, input)
          output = input
          array_layer.each do |array|
            output = (array[1]..(array[1] + array[2])).include?(input) ? output - array[1] + array[0] : output
          end
          output
        end

        def range_intersection(range_1, range_2)
          return nil if range_1.end < range_2.begin || range_2.end < range_1.begin
          [range_1.begin, range_2.begin].max..[range_1.end, range_2.end].min
        end

        def range_subtract(range_1, range_2)
          intersection = range_intersection(range_1, range_2)
          return [range_1] unless intersection
          output = []
          output.push(range_1.begin...(intersection.begin)) if range_1.begin < intersection.begin
          output.push((intersection.end + 1)..range_1.end) if intersection.end < range_1.end
          output
        end

        def range_transformer(array_layer, ranges)
          output_ranges = []
          input_ranges = ranges.dup

          array_layer.each do |array|
            layer_ranges = []

            input_ranges.each do |range|
              source_range = array[1]..(array[1] + array[2] - 1)

              x = range_intersection(range, source_range)

              offset = array[0] - array[1]
              output_ranges.push((x.begin + offset)..(x.end + offset)) if x

              layer_ranges += range_subtract(range, source_range)
            end

            input_ranges = layer_ranges
          end

          output_ranges + input_ranges
        end

        def seeds_and_layers
          seeds, *layers = input_blob.split("\n\n").map { |s| s.scan(/\d+/).map(&:to_i) }
          layers.map! { |a| a.each_slice(3) }.map! { |a| a.to_a }
          [seeds, *layers]
        end

        def run_a
          seeds, *layers = seeds_and_layers

          seeds.map do |seed|
            location = seed
            layers.each do |layer|
              location = input_transformer(layer, location)
            end
            location
          end.min
        end

        def run_b
          seeds, *layers = seeds_and_layers

          seeds.each_slice(2).map do |lower, length|
            ranges = [lower..(lower + length - 1)]
            
            layers.each do |layer|
              ranges = range_transformer(layer, ranges)
            end

            ranges.map(&:begin).min
          end.min
        end
      end
    end
  end
end
