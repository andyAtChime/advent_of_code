require_relative '../../day.rb'
require 'set'

module AdventOfCode
  module Year2022
    class AdventOfCode::Year2022::Day06 < AdventOfCode::Day
      DAY = 6
      YEAR = 2022
      INPUT_PARSER = lambda { |line| line.scan(/./) }

      class << self
        def regex_solution(size)
          r = "(\\w)"
          (1..(size - 1)).each do |i|
            (1..i).each do |j|
              r += "(?!\\#{j})"
            end
            r += "(\\w)"
          end

          ((Regexp.new r) =~ input_blob) + size
        end

        def run_a
          regex_solution(4)
        end

        def run_b
          regex_solution(14)
        end
      end
    end
  end
end
