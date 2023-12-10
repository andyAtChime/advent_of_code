require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day10 < AdventOfCode::Day
      DAY = 10
      YEAR = 2023
      INPUT_PARSER = lambda { |line| line.split("") }

      ADJACENCY_MAP = {
        "|" => %i[u d],
        "-" => %i[l r],
        "F" => %i[d r],
        "7" => %i[d l],
        "J" => %i[u l],
        "L" => %i[r u],
        "S" => %i[],
        "." => [],
      }.freeze

      OPPOSITES = { u: :d, r: :l }.tap { |h| h.merge!(h.invert) }.freeze

      class Tree
        attr_accessor :root, :nodes

        def initialize(input)
          @root = nil
          @nodes = {}
          input.each_with_index do |row, i|
            row.each_with_index do |val, j|
              node = Node.new(i, j, val)
              node.set_adjacencies!(input)
              @root = node if val == "S"
              @nodes[[i, j]] = node
            end
          end
        end

        def bfs
          to_search = [root]
          distances = {root => 0}

          until to_search.empty?
            node = to_search.shift
            current_distance = distances[node]
            node.adjacencies.each do |k, (i, j)|
              adjacent = @nodes[[i, j]]
              if !node.visited && !adjacent.visited
                to_search << @nodes[[i, j]]
                distances[@nodes[[i, j]]] = current_distance + 1
              end
            end
            node.visited = true
          end

          distances.values.max
        end
      end

      class Node
        attr_accessor :i, :j, :val, :adjacencies, :visited

        def initialize(i, j, val)
          @i = i
          @j = j
          @val = val
          @adjacencies = []
          @visited = false
        end
        
        def all_adjacencies(i, j, input)
          { u: [i - 1, j], d: [i + 1, j], l: [i, j - 1], r: [i, j + 1] }.select do |k, (i, j)|
            (0...input.length).include?(i) && (0...input[i].length).include?(j)
          end
        end

        def set_adjacencies!(input)
          if val != "S"
            attempted_ajacencies = ADJACENCY_MAP[val]
            @adjacencies = all_adjacencies(i, j, input).select do |k, _|
              attempted_ajacencies.include?(k)
            end
          else
            dirs = []
            @adjacencies = all_adjacencies(i, j, input).select do |k, (i, j)|
              adjacent = ADJACENCY_MAP[input[i][j]]
              dirs << k if adjacent&.include?(OPPOSITES[k])
            end

            # substitute out the S for its practical value
            @val = ADJACENCY_MAP.map { |k, values| k if values.sort == dirs.sort }.compact.first
          end
        end
      end

      class << self
        def run_a
          tree = Tree.new(parsed_input)
          tree.bfs
        end

        def run_b
          tree = Tree.new(parsed_input)
          tree.bfs

          counter = 0
          parsed_input.each_with_index.map do |row, i|
            u, d = 0, 0
            (0...row.length).map do |j|
              node = tree.nodes[[i, j]]
              if node.visited
                ADJACENCY_MAP[node.val].include?(:u) && u += 1
                ADJACENCY_MAP[node.val].include?(:d) && d += 1
              else
                counter += 1 if u.odd? && d.odd?
              end
            end
          end

          counter
        end
      end
    end
  end
end
