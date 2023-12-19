require_relative '../../day.rb'
require 'set'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day17 < AdventOfCode::Day
      DAY = 17
      YEAR = 2023
      INPUT_PARSER = lambda { |line| line.split("") }

      class Graph
        class Node
          INVERSE = { u: :d, d: :u, l: :r, r: :l }
          attr_accessor :x, :y, :direction, :consecutive_count, :heat_value, :neighbors
          def initialize(x, y, direction, consecutive_count, heat_value)
            @x = x
            @y = y
            @direction = direction
            @consecutive_count = consecutive_count
            @heat_value = heat_value
            @neighbors = []
          end

          def sort_key
            -x - y
          end

          def available_directions(min, max)
            [:u, :r, :d, :l]
              .reject { |d| d == INVERSE[@direction] }
              .reject { |d| d == @direction && @consecutive_count >= max }
              .reject { |d| d != @direction && @consecutive_count < min }
          end

          def new_coordinates(direction)
            case direction
            when :u
              [0, -1]
            when :r
              [1, 0]
            when :d
              [0, 1]
            when :l
              [-1, 0]
            end.zip([@x, @y]).map(&:sum)
          end
        end

        attr_accessor :nodes
        def initialize(nodes, min, max)
          @nodes = nodes
          max_x = nodes.first.size - 1
          max_y = nodes.size - 1

          nodes.each_with_index.map do |line, y|
            line.each_with_index.map do |consecutive_counts, x|
              consecutive_counts.map do |directions|
                directions.values.map do |node|
                  node.available_directions(min, max).each do |direction|
                    new_x, new_y = node.new_coordinates(direction)
                    if new_x >= 0 && new_x <= max_x && new_y >= 0 && new_y <= max_y
                      new_count = direction == node.direction ? node.consecutive_count + 1 : 1
                      node.neighbors << @nodes[new_y][new_x][new_count][direction]
                    end
                  end
                end
              end
            end
          end
        end

        def traverse
          # create a priority_queue of nodes to visit
          to_visit = Hash.new([]).tap { |h| h[0] = [nodes[0][0][0][:r]] }
          visited = Set.new
          
          while to_visit.any? do
            pp "to_visit"
            visit_distance = to_visit.keys.min
            current_level = to_visit.delete(visit_distance).sort_by(&:sort_key)
            current_level.each do |node|
              visiting = current_level.pop
              next if visited.include?(visiting)
              visited << visiting
              return visit_distance if visiting.x == nodes.first.size - 1 && visiting.y == nodes.size - 1

              visiting.neighbors.each do |neighbor|
                to_visit[neighbor.heat_value] << neighbor unless visited.include?(neighbor)
                pp visited.include?(neighbor)
                pp neighbor.heat_value
                pp to_visit[neighbor.heat_value].map { |n| [n.x, n.y, n.direction, n.consecutive_count] }
              end
            end
          end
          pp visited.map { |n| [n.x, n.y, n.direction, n.consecutive_count] }
          pp visited.first.neighbors.map { |n| [n.x, n.y, n.direction, n.consecutive_count] }
        end

        class << self
          def from_input(parsed_input, min, max)
            new(
              parsed_input.map.with_index do |line, y|
                line.map.with_index do |value, x|
                  0.upto(max).map do |consecutive_count|
                    [:u, :r, :d, :l].map do |direction|
                      [direction, Node.new(x, y, direction, consecutive_count, value.to_i)]
                    end.to_h
                  end
                end
              end , min, max)
          end
        end
      end

      class << self
        VISUALIZER = { u: "^", d: "v", l: "<", r: ">" }

        def run_a
          graph = Graph.from_input(parsed_input, 1, 3)
          graph.traverse
        end

        def run_b
          # put your code here
        end
      end
    end
  end
end
