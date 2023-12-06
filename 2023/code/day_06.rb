require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day06 < AdventOfCode::Day
      DAY = 6
      YEAR = 2023
      INPUT_PARSER = lambda { |line| line.scan(/\d+/).map(&:to_i) }

      class << self
        def distance(total_time, charge_time)
          (total_time - charge_time) * charge_time
        end

        def use_quadratic_formula(total_time, distance_record)
          a = -1
          b = total_time
          c = distance_record * -1
          root = (b ** 2 - (4 * a * c)) ** 0.5
          ((-b - root) / (2 * a)).ceil - ((-b + root) / (2 * a)).floor -  1
        end

        def run_a
          times = parsed_input[0]
          distances = parsed_input[1]
          pairs = times.zip(distances)
          pairs.map do |time, distance|
            # slow solution
            # (1..(time - 1)).map do |charge_time|
            #   distance(time, charge_time) > distance ? 1 : 0
            # end.sum

            use_quadratic_formula(time, distance)
          end.reduce(:*)
        end

        def run_b
          time = input_lines[0].gsub(/\D/, "").to_i
          distance = input_lines[1].gsub(/\D/, "").to_i
          return use_quadratic_formula(time, distance)

          # slow solution
          (1..(time - 1)).map do |charge_time|
            distance(time, charge_time) > distance ? 1 : 0
          end.sum
        end
      end
    end
  end
end
