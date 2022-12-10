require_relative '../../day.rb'

module AdventOfCode
  module Year2022
    class AdventOfCode::Year2022::Day10 < AdventOfCode::Day
      DAY = 10
      YEAR = 2022
      INPUT_PARSER = lambda { |line| line.split(" ")}

      class << self
        def register_values
          x = 1
          @register_values ||= parsed_input.each_with_object([]) do |line, a|
            line.size.times { a << x }
            x += line[1].to_i if line.size > 1
          end
        end

        def run_a
          (20..220).step(40).sum {|i| register_values[i - 1] * i }
        end

        def run_b
          register_values
            .zip((0...240))
            .map {|a, b|  (a - b % 40).abs <= 1 ? "\u2588" : " "}
            .each_slice(40)
            .map(&:join)
            .join("\n")
        end
      end
    end
  end
end
