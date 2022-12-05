require_relative '../../day.rb'

module AdventOfCode
  module Year2022
    class AdventOfCode::Year2022::Day05 < AdventOfCode::Day
      DAY = 5
      YEAR = 2022
      INPUT_PARSER = lambda { |line| line }

      class << self
        def input_columns
          (1..33).step(4).each_with_object([]) do |i, a|
            sub = []

            (7..0).step(-1).each do |x|
              letter = parsed_input[x][i]
              sub << letter unless letter == " "
            end

            a << sub
          end
        end

        def instructions
          parsed_input.map do |line|
            a = (/move (?<amount>\d*) from (?<start>\d*) to (?<finish>\d*)/ =~ line)
            {amount: amount.to_i, start: start.to_i - 1, finish: finish.to_i - 1} if a
          end.compact
        end

        def move!(&block)
          columns = input_columns

          instructions.each do |instruction|
            stack = columns[instruction[:start]].pop(instruction[:amount])
            columns[instruction[:finish]] += block_given? ? block.call(stack) : stack
          end

          columns.map { |c| c[-1] }.join("")
        end
        
        def run_a
          move! { |s| s.reverse }
        end

        def run_b
          move!
        end
      end
    end
  end
end
