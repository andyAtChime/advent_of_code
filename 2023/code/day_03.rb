require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day03 < AdventOfCode::Day
      DAY = 3
      YEAR = 2023
      INPUT_PARSER = lambda { |line| line }

      class << self
        def parsed_input
          [""] + super + [""]
        end

        def symbol_indices(line)
          line.chars.each_with_index.select { |c, i| !c.match?(/\d|\./) }.map(&:last)
        end

        def number_indices(line)
          res = []
          line.scan(/\d+/) do |c|
            i = $~.offset(0)[0]
            res << [c, (i-1)..(i+c.length)]
          end
          res
        end

        def run_a
          symbols = parsed_input.map { |line| symbol_indices(line) }
          symbols = symbols.rotate(-1).zip(symbols).zip(symbols.rotate).map(&:flatten).map(&:uniq).map(&:sort)
          numbers = parsed_input.map { |line| number_indices(line) }

          symbols.zip(numbers).map do |symbol_line, number_line|
            number_line.map do |number, range|
              symbol_line.any? { |symbol| range.include?(symbol) } ? number.to_i : 0
            end.sum
          end.sum
        end

        def gear_indices(line)
          (0..line.length).select { |i| line[i] == "*" }
        end

        def run_b
          symbols = parsed_input.map { |line| gear_indices(line) }
          numbers = parsed_input.map { |line| number_indices(line) }
          numbers = numbers.rotate(-1).zip(numbers, numbers.rotate).map { |a| a.flatten(1) }

          symbols.zip(numbers).map do |symbol_line, number_line|
            symbol_line.map do |index|
              matches = number_line.map do |number, number_range|
                number if number_range.include?(index)
              end.compact
              matches.length == 2 ? matches[0].to_i * matches[1].to_i: 0
            end
          end.flatten.sum
        end
      end
    end
  end
end
