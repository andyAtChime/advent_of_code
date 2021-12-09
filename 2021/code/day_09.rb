require_relative '../../day.rb'
require 'set'

module AdventOfCode
  module Year2021
    class AdventOfCode::Year2021::Day09 < AdventOfCode::Day
      DAY = 9
      YEAR = 2021
      INPUT_PARSER = lambda { |line| line.split("").map(&:to_i) }

      class << self
        def run_a
          total = 0
          parsed_input.each_with_index do |line, i|
            line.each_with_index do |number, j|
              if j - 1 >= 0
                next unless line[j - 1] > number
              end
              if line[j + 1]
                next unless number < (line[j + 1])
              end
              if i - 1 >= 0
                next unless parsed_input[i - 1][j] > number
              end
              if parsed_input[i + 1]
                next unless number < parsed_input[i + 1][j]
              end
              total += number + 1
            end
          end
          total
        end
        
        def run_b
          ranges = parsed_input.map { |line| ranges_for(line) }
          b = BasinGraph.new(ranges).get_basins.sort
          b[-1] * b[-2] * b[-3]
        end

        def ranges_for(line)
          nine_indices = []
          line.each_index { |i| nine_indices << i if line[i] == 9 }
          ranges = []
          ranges << Set[*0...(nine_indices[0] || line.length)] if nine_indices[0] > 0

          nine_indices.each_index do |i|
            a = (nine_indices[i] + 1)
            b = (nine_indices[i + 1] || line.length)
            ranges << Set[*a...b] if a < b
          end
          ranges
        end

        class BasinGraph
          attr_accessor :nodes
          def initialize(ranges)
            @nodes = []
            ranges.each_index do |row|
              ranges[row].each_index do |node|
                add_node(ranges[row][node], row)
              end
            end
          end

          def add_node(range, row)
            node = BasinNode.new(range, row) 
            nodes.each do |other|
              if node.neighbor?(other)
                node.add_neighbor(other)
                other.add_neighbor(node)
              end
            end
            nodes << node
          end

          def get_basins
            basins = []
            @nodes.each do |node|
              basins << node.visit unless node.visited
            end
            basins
          end

          class BasinNode
            attr_reader :range, :row, :visited

            def initialize(range, row)
              @range = range
              @row = row
              @neighbors = []
              @value = range.size
              @visited = false
            end

            def neighbor?(other)
              (range & other.range).length > 0 &&
                (row - other.row).abs <= 1
            end

            def add_neighbor(other)
              @neighbors << other
            end

            def visit
              return 0 if @visited
              @visited = true
              return @value + @neighbors.map(&:visit).sum
            end
          end
        end
      end
    end
  end
end
