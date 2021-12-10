require_relative '../../day.rb'

module AdventOfCode
  module Year2021
    class AdventOfCode::Year2021::Day10 < AdventOfCode::Day
      DAY = 10
      YEAR = 2021
      INPUT_PARSER = lambda { |line| line }

      class << self
        def evaluate_line(line)
          stack = []
          closers = { "}" => "{", "]" => "[", ")" => "(", ">" => "<" }
          line.split("").each do |char|
            if closers.values.include?(char)
              stack << char
            elsif closers[char] == stack[-1]
              stack.pop
            else
              return [stack, char]
            end
          end
          return [stack.map { |s| closers.invert[s] }.reverse.join(""), nil]
        end

        def get_error_score(char)
          { "}" => 1197, "]" => 57, ")" => 3, ">" => 25137 }[char]
        end

        def get_stack_score(line)
          scores = { "}" => 3, "]" => 2, ")" => 1, ">" => 4 }
          s = 0
          line.split("").each do |i|
            s *= 5
            s += scores[i]
          end
          s
        end

        def run_a
          parsed_input
            .map { |l| evaluate_line(l)[1] }
            .compact
            .map { |l| get_error_score(l) }
            .sum
        end

        def run_b
          b = parsed_input
            .map { |l| evaluate_line(l) }
            .select { |l| l[1].nil? }
            .map { |l| get_stack_score(l[0]) }
            .sort
          b[b.size / 2]
        end
      end
    end
  end
end
