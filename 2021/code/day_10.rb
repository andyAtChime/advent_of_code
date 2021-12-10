require_relative '../../day.rb'

module AdventOfCode
  module Year2021
    class AdventOfCode::Year2021::Day10 < AdventOfCode::Day
      DAY = 10
      YEAR = 2021
      INPUT_PARSER = lambda { |line| line }

      class << self
        def get_invalid_character(line)
          stack = []
          closers = { "}" => "{", "]" => "[", ")" => "(", ">" => "<" }
          line.split("").each do |char|
            if closers.values.include?(char)
              stack << char
            elsif closers[char] == stack[-1]
              stack.pop
            else
              return char
            end
          end
          return nil
        end

        def finish_stack(line)
          stack = []
          closers = { "}" => "{", "]" => "[", ")" => "(", ">" => "<" }
          openers = closers.invert
          line.split("").each do |char|
            if closers.values.include?(char)
              stack << char
            elsif closers[char] == stack[-1]
              stack.pop
            end
          end
          output = stack.map { |s| openers[s] }.reverse.join("")
        end

        def get_score(char)
          { "}" => 1197, "]" => 57, ")" => 3, ">" => 25137 }[char]
        end

        def run_a
          parsed_input
            .map { |l| get_invalid_character(l) }
            .compact
            .map { |l| get_score(l) }
            .sum
        end

        def get_score_b(line)
          scores = { "}" => 3, "]" => 2, ")" => 1, ">" => 4 }
          s = 0
          line.split("").each do |i|
            s *= 5
            s += scores[i]
          end
          s
        end

        def run_b
          b = parsed_input
            .select { |l| get_invalid_character(l).nil? }
            .map { |l| finish_stack(l)}
            .map { |l| get_score_b(l)}
            .sort
          b[b.size / 2]
        end
      end
    end
  end
end
