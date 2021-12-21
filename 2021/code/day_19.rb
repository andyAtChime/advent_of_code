require_relative '../../day.rb'

module AdventOfCode
  module Year2021
    class AdventOfCode::Year2021::Day19 < AdventOfCode::Day
      DAY = 19
      YEAR = 2021
      # INPUT_PARSER = lambda { |line| line }

      class Scanner
        attr_reader :beacons, :id

        def initialize(id, readings)
          @id = id
          @beacons = readings.map { |r| Beacon.new(r) }
        end

        def single_axis_alignment(other)
          p [id, other.id]
          [:a, :b, :c].each do |axis|
            [1, -1].each do |sign|
              comparisons = compare_axes(other, :a, axis, sign)
            end
          end
          nil
        end

        def compare_axes(other, a1, a2, sign)
          @beacons.each_index do |i|
            difference = self[i][a1] - other[0][a2] * sign
            overlap = @beacons.map { |b| b[a1] } &
              other.beacons.map { |b| b[a2] * sign + difference }
            p [overlap.size, a1, a2, sign]
            # if overlap.size >= 12
            #   return overlap.map do |x|
            #     [
            #       @beacons.find { |b| b[a1] == x},
            #       other.beacons.find { |b| b[a2] * sign + difference == x},
            #     ]
            #   end
            # end
          end
          nil
        end

        def sorted_axis(axis, sign)
          @beacons.sort_by { |b| b[axis] }
        end

        def [](i)
          @beacons[i]
        end
      end

      class Beacon
        attr_reader :reading

        def initialize(reading)
          @reading = reading
        end

        def [](axis)
          @reading[ {a: 0, b: 1, c: 2}[axis] ]
        end
      end

      class << self
        def scanners
          input_segments = input_blob.split("\n\n")
          input_segments.map do |s|
            scanner_id, *beacon_inputs = s.split("\n")
            Scanner.new(
              scanner_id,
              s.split("\n").map {|b| b.split(",").map(&:to_i)}.reject {|b| b.size == 1}
            )
          end
        end

        def run_a
          scanners.combination(2).each do |a, b|
            a.single_axis_alignment(b)
          end
          nil
        end

        def run_b
          # put your code here
        end
      end
    end
  end
end
