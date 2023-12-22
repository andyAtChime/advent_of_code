require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day19 < AdventOfCode::Day
      DAY = 19
      YEAR = 2023
      INPUT_PARSER = lambda { |line| line }

      class Instruction
        class << self
          def string_wrap(string)
            "\"#{string}\""
          end

          def from_input(input)
            input, _ = input.split("}")
            name, rules = input.split("{")
            rules = rules.split(",")
            default = string_wrap(rules.pop)
            eval_string = rules.reverse.reduce(default) do |acc, rule|
              criterion, result = rule.split(":")
              result = string_wrap(result)
              result == acc ? acc : "(#{criterion} ? #{result} : #{acc})"
            end
            new(name, eval_string)
          end
        end

        attr_accessor :name, :eval_string

        def initialize(name, eval_string)
          @name = name
          @eval_string = eval_string
        end

        def evaluate(input)
          x, m, a, s = input.values_at(:x, :m, :a, :s)
          eval(eval_string)
        end
      end

      class << self
        def input
          instructions, inputs = input_blob.split("\n\n").map { |chonk| chonk.split("\n") }
          {
            instructions: instructions.map { |i| Instruction.from_input(i) }.map { |i| [i.name, i] }.to_h,
            inputs: inputs.map { |line| eval(line.gsub("=", ": ")) }
          }
        end

        def run_a
          instructions, inputs = input.values_at(:instructions, :inputs)
          inputs.map do |input|
            next_instruction = "in"
            while !next_instruction.match(/R|A/)
              next_instruction = instructions[next_instruction].evaluate(input)
            end
            next_instruction == "A" ? input.values.sum : 0
          end.sum
        end

        def run_b
          instructions, _ = input_blob.split("\n\n")
          instructions.map { |chonk| chonk.split("\n") }.map do |line|
            line, _ = line.split("}")
            name, rules = line.split("{")
            rules = rules.split(",")
            default = rules.pop
            rules.pop while rules.last[-1] == default
            rules.map do |r|
              criterion, val = r.split(":")
              
            end
          end
        end
      end
    end
  end
end
