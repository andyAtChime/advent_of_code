require_relative '../../day.rb'
require 'set'

module AdventOfCode
  module Year2021
    class AdventOfCode::Year2021::Day12 < AdventOfCode::Day
      DAY = 12
      YEAR = 2021
      # modify if necessary
      INPUT_PARSER = lambda { |line| line.split('-') }

      class CaveGraph
        attr_accessor :nodes

        def initialize(input_lines, a=true)
          @nodes = {}
          @a = a
          input_lines.each do |edge|
            add_edge(*edge)
          end
        end

        def add_edge(node_1, node_2)
          create_node(node_1)
          create_node(node_2)
          @nodes[node_1][:neighbors] << node_2
          @nodes[node_2][:neighbors] << node_1
        end

        def create_node(node)
          @nodes[node] = {neighbors: []} unless @nodes[node]
        end

        def find_paths
          nodes["start"][:neighbors]
            .map { |node_name| search(node_name, ["start"]) }
            .sum
        end

        def search(node_name, visited)
          if node_name == "end"
            if @a
              return 1
            else
              downcased = visited.select {|x| x.downcase == x}
              return downcased.size - 1 > downcased.uniq.size ? 0 : 1
            end
          end
          neighbors = @nodes[node_name][:neighbors]
          valid = valid_neighbors(neighbors - ['start'], visited)

          return 0 if valid.size == 0
          return valid.map { |n| search(n, visited.clone << node_name) }.sum
        end

        def valid_neighbors(neighbors, visited)
          downcased = visited.select {|x| x.downcase == x}
          if @a 
            return neighbors - downcased
          elsif downcased == downcased.uniq
            return neighbors.clone
          else
            return neighbors - downcased
          end
        end
      end

      class << self
        def run_a
          g = CaveGraph.new(parsed_input, true).find_paths
        end

        def run_b
          g = CaveGraph.new(parsed_input, false).find_paths
        end
      end
    end
  end
end
