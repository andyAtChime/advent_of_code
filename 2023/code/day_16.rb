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
          @accessed = {u: nil, d: nil, l: nil, r: nil}
          @neighbors = {u: nil, d: nil, l: nil, r: nil}
          @segment = nil
        end

        def light
          accessed.values.any? ? "#" : "."
        end

        def seg_light(segments)
          accessed.values.any? { |v| segments.include?(v) } ? "#" : symbol
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

      class LightNodeSegment
        attr_accessor :start, :nodes, :children, :directions, :index
        def initialize(start, from, index)
          @nodes = [start]
          @directions = [from]
          @children = {}
          @index = index
        end

        def length
          nodes.size
        end

        def child_nodes
          next_segments = [self]
          seen_segments = {self => 0}
          until next_segments.empty? do
            seg = next_segments.shift
            seg.children.each do |child, index|
              existing_index = seen_segments[child]
              if !existing_index
                next_segments << child
                seen_segments[child] = index
              else
                seen_segments[child] = index if index < existing_index
              end
            end
          end
          seen_segments.map { |k, v| k.nodes[v..] }.flatten.uniq
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

        def get_segments(node_hash)
          traversal_segments = []
          segment_count = 0
          node_hash.each do |node, from|
            traversal_segments << LightNodeSegment.new(node, from, segment_count += 1)
          end
          
          edge_segments = traversal_segments

          i = 0
          while traversal_segments.any? do
            segments = traversal_segments
            traversal_segments = []

            segments.each do |segment|
              node = segment.nodes.last
              from = segment.directions.last
              node.accessed[from] = segment

              out_directions = node.out_directions[from]
              node.out_directions[from].each do |out_direction|
                next_in = INVERSE[out_direction]
                neighbor = node.neighbors[out_direction]
                if neighbor
                  existing_segment = neighbor.accessed[next_in]
                  if existing_segment
                    segment.children[existing_segment] = existing_segment.nodes.index(neighbor)
                  elsif next_in == from
                    segment.nodes << neighbor
                    segment.directions << next_in
                    traversal_segments << segment
                  else
                    s = LightNodeSegment.new(neighbor, next_in, segment_count += 1)
                    segment.children[s] = 0
                    traversal_segments << s
                  end
                end
              end
            end
          end
          edge_segments
        end
      end

      class << self

        def run_a
          graph = LightNodeGraph.from_input(parsed_input)
          segment = graph.get_segments(graph.nodes.first.first => :l).first
          segment.child_nodes.size
        end

        def run_b
          graph = LightNodeGraph.from_input(parsed_input)
          nodes = graph.nodes.dup
          mass_traversal_starts = {}
          graph.nodes.each_with_index.map do |line, y|
            line.each_with_index.map do |node, x|
              mass_traversal_starts[node] = :l if x == 0
              mass_traversal_starts[node] = :r if x == line.size - 1
              mass_traversal_starts[node] = :u if y == 0
              mass_traversal_starts[node] = :d if y == graph.nodes.size - 1
            end
          end

          edge_segments = graph.get_segments(mass_traversal_starts)

          edge_segments.map do |seg|
            seg.child_nodes.size
          end.max
        end
      end
    end
  end
end
