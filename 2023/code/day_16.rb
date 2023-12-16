require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day16 < AdventOfCode::Day
      DAY = 16
      YEAR = 2023
      INPUT_PARSER = lambda { |line| line.split("") }

      class LightNode
        attr_accessor :x, :y, :symbol, :accessed, :neighbors

        class << self
          def from_symbol(x, y, symbol)
            case symbol            
            when "|"
              VSplitNode.new(x, y, symbol)
            when "-"
              HSplitNode.new(x, y, symbol)
            when "/"
              FSlashNode.new(x, y, symbol)
            when "\\"
              BSlashNode.new(x, y, symbol)
            else
              LightNode.new(x, y, symbol)
            end
          end
        end

        def initialize(x, y, symbol)
          @x = x
          @y = y
          @symbol = symbol
          @accessed = {u: false, d: false, l: false, r: false}
          @neighbors = {u: nil, d: nil, l: nil, r: nil}
        end

        def light
          accessed.values.any? ? "#" : "."
        end
        
        def out_directions
          { u: [:d], d: [:u], l: [:r], r: [:l] }
        end
      end

      class VSplitNode < LightNode
        def out_directions
          { u: [:d], d: [:u], l: [:u, :d], r: [:u, :d] }
        end
      end

      class HSplitNode < LightNode
        def out_directions
          { u: [:l, :r], d: [:l, :r], l: [:r], r: [:l] }
        end
      end

      class FSlashNode < LightNode
        def out_directions
          { u: [:l], d: [:r], l: [:u], r: [:d] }
        end
      end

      class BSlashNode < LightNode
        def out_directions
          { u: [:r], d: [:l], l: [:d], r: [:u] }
        end
      end

      class LightNodeGraph
        INVERSE = {l: :r, r: :l, u: :d, d: :u}
        
        attr_accessor :nodes
        class << self
          def from_input(input)
            nodes = input.each_with_index.map do |line, y|
              line.each_with_index.map do |symbol, x|
                LightNode.from_symbol(x, y, symbol)
              end
            end

            nodes.each do |line|
              line.each do |node|
                node.neighbors[:u] = nodes[node.y - 1][node.x] if node.y > 0
                node.neighbors[:d] = nodes[node.y + 1][node.x] if node.y < nodes.size - 1
                node.neighbors[:l] = nodes[node.y][node.x - 1] if node.x > 0
                node.neighbors[:r] = nodes[node.y][node.x + 1] if node.x < nodes.first.size - 1
              end
            end

            new(nodes)
          end
        end

        def initialize(nodes)
          @nodes = nodes
        end

        def bfs_traverse(x_start, y_start, from)
          start_node = @nodes[y_start][x_start]
          next_layer = [[start_node, from]]
          until next_layer.empty? do
            layer = next_layer
            next_layer = []

            until layer.empty? do
              node, from = layer.shift
              next if node.accessed[from]
              node.accessed[from] = true

              node.out_directions[from].each do |out_direction|
                neighbor = node.neighbors[out_direction]
                next_layer << [neighbor, INVERSE[out_direction]] if neighbor
              end
            end
            # pretty_print
          end
          return nodes.flatten.count { |n| n.accessed.values.any? }
        end

        def pretty_print
          puts @nodes.map { |line| line.map(&:light).join("") }.join("\n") + "\n\n"
        end

        def reset
          nodes.each do |line|
            line.each do |node|
              node.accessed = {u: false, d: false, l: false, r: false}
            end
          end
        end
      end

      class << self
        def run_a
          LightNodeGraph.from_input(parsed_input).bfs_traverse(0, 0, :l)
        end

        def run_b
          graph = LightNodeGraph.from_input(parsed_input)
          nodes = graph.nodes.dup
          graph.nodes.each_with_index.map do |line, y|
            line.each_with_index.map do |node, x|
              a = x == 0 ? graph.bfs_traverse(x, y, :l) : 0
              b = x == line.size - 1 ? graph.bfs_traverse(x, y, :r) : 0
              graph.reset if a > 0 || b > 0
              c = y == 0 ? graph.bfs_traverse(x, y, :u) : 0
              d = y == graph.nodes.size - 1 ? graph.bfs_traverse(x, y, :d) : 0
              graph.reset if c > 0 || d > 0
              [a, b, c, d]
            end
          end.flatten.max
        end
      end
    end
  end
end
