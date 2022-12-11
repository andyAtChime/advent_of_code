require_relative '../../day.rb'

module AdventOfCode
  module Year2022
    class AdventOfCode::Year2022::Day11 < AdventOfCode::Day
      DAY = 11
      YEAR = 2022
      INPUT_PARSER = lambda { |line| line}

      class << self
        class Monkey
          attr_accessor :items, :transform, :test, :yes, :no, :inspected

          def initialize(input)
            @inspected = 0
            @items = eval("[#{input[1].split(': ')[1]}]")

            test = input[2].split(' = ')[1]
            @transform = -> old { eval(test) / 3 }

            mod = input[3].split('by ')[1]
            @test = -> n { n % mod.to_i == 0 }

            @yes = input[4][-1].to_i
            @no = input[5][-1].to_i
          end

          def shift
            @inspected += 1
            item = transform.call(@items.shift)
            output = @test.call(item)
            [item, output ? yes : no]
          end

          def run_all(&block)
            while items.size > 0 do 
              block.call(*shift)
            end
          end
        end

        def run_a
          monkeys = separated_input.map {|lines| Monkey.new(lines) }
          20.times do
            monkeys.each do |monkey|
              monkey.run_all do |item, i|
                monkeys[i].items << item
              end
            end
          end
          monkeys.map(&:inspected).sort.reverse[0..1].reduce(1) {|a,b| a *b }
        end

        def run_b
          # put your code here
        end
      end
    end
  end
end
