require_relative '../../day.rb'

module AdventOfCode
  module Year2022
    class AdventOfCode::Year2022::Day13 < AdventOfCode::Day
      DAY = 13
      YEAR = 2022
      INPUT_PARSER = lambda { |line| eval(line) }

      class << self
        def compare(a, b)
          n = [a.size, b.size].min
          n.times do |i|
            case [a[i].is_a?(Integer), b[i].is_a?(Integer)]

            when [true, false]
              c = compare([a[i]], b[i])
              return c unless c == 0

            when [false, true]
              c = compare(a[i], [b[i]])
              return c unless c == 0

            when [true, true]
              c = a[i] - b[i]
              return 1 if c < 0
              return -1 if c > 0

            when [false, false]
              c = compare(a[i], b[i])
              return c unless c == 0

            end
          end

          return 0 if a.size == b.size
          return a.size < b.size ? 1 : -1
        end

        def run_a
          sum = 0
          separated_input(nil)
            .map {|a| compare(*a)}
            .each_with_index {|a,i| sum += i + 1 if a > 0 }
          sum
        end

        def run_b
          a = (parsed_input.compact + [[[2]], [[6]]]).sort {|a, b| -1 * compare(a, b)}
          (1 + a.index([[2]])) * (1 + a.index([[6]]))
        end
      end
    end
  end
end
