require_relative '../../day.rb'

module AdventOfCode
  module Year2021
    class AdventOfCode::Year2021::Day11 < AdventOfCode::Day
      DAY = 11
      YEAR = 2021
      INPUT_PARSER = lambda { |line| line.split('').map(&:to_i) }

      class << self
        class OctopusGraph
          attr_accessor :nodes

          def initialize(input_lines)
            @nodes = []
            input_lines.each_index do |row|
              input_lines[row].each_index do |column|
                add_node(row, column, input_lines[row][column])
              end
            end
          end

          def add_node(row, column, value)
            node = OctopusNode.new(row, column, value) 
            nodes.each do |other|
              if node.neighbor?(other)
                node.add_neighbor(other)
                other.add_neighbor(node)
              end
            end
            nodes << node
          end

          def visit_all
            @nodes.each(&:visit)
            @nodes.each(&:reset)
          end

          def total_flashes
            nodes.map(&:flashes).sum
          end

          def synced?
            nodes.map { |node| node.value == 0 }.all?
          end

          class OctopusNode
            attr_accessor :row, :column, :visited, :flashes, :value

            def initialize(row, column, value)
              @row = row
              @column = column
              @neighbors = []
              @value = value
              @flashes = 0
            end

            def neighbor?(other)
              (column - other.column).abs <= 1 && (row - other.row).abs <= 1
            end

            def add_neighbor(other)
              @neighbors << other
            end

            def visit
              @value += 1
              if @value == 10
                @flashes += 1
                @neighbors.each do |neighbor|
                  neighbor.visit if neighbor.value < 10
                end
              end
            end

            def reset
              @value = 0 if @value > 9
            end
          end
        end

        def run_a
          g = OctopusGraph.new(parsed_input)
          100.times { g.visit_all }
          g.total_flashes
        end

        def run_b
          g = OctopusGraph.new(parsed_input)
          10000.times do |i|
            g.visit_all
            return i + 1 if g.synced?
          end
        end
      end
    end
  end
end
