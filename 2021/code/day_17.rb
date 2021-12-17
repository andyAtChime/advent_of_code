require_relative '../../day.rb'

module AdventOfCode
  module Year2021
    class AdventOfCode::Year2021::Day17 < AdventOfCode::Day
      DAY = 17
      YEAR = 2021
      INPUT_PARSER = lambda do |line|
        line[13..].split(", ").map do |equals|
          eval(equals.split("=")[1])
        end
      end


      class Launch
        attr_reader :x, :y

        def initialize(dx, dy)
          @dx, @dy = dx, dy
          @x, @y = 0, 0
          @locations = []
        end

        def step
          @x += @dx
          @y += @dy
          @locations << [@x, @y]
          @dx = [@dx - 1, 0].max
          @dy -= 1
        end

        def max_height
          @locations.map {|x, y| y}.max
        end
      end

      class BruteForceLauncher
        def initialize(x_range, y_range)
          @x_range = x_range
          @y_range = y_range
          @launches = []
        end

        def run_all
          search_x = 0..(@x_range.max)
          search_y = (@y_range.min..(-1 * @y_range.min))

          @launches = search_x.map { |x| search_y.map { |y| Launch.new(x, y) } }.flatten
          @launches.each { |launch| run(launch) }
        end

        def run(launch)
          until success?(launch) || failure?(launch) do
            launch.step
          end
        end

        def successes
          @launches.select { |launch| success?(launch) }
        end

        def success?(launch)
          @x_range.include?(launch.x) && @y_range.include?(launch.y)
        end

        def failure?(launch)
          launch.x > @x_range.max || launch.y < @y_range.min
        end
      end

      class << self
        def successes
          BruteForceLauncher.new(*parsed_input[0]).tap { |b| b.run_all }.successes
        end

        def run_a
          successes.map { |launch| launch.max_height }.max
        end

        def run_b
          successes.size
        end
      end
    end
  end
end
