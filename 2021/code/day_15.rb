require_relative '../../day.rb'

module AdventOfCode
  module Year2021
    class AdventOfCode::Year2021::Day15 < AdventOfCode::Day
      DAY = 15
      YEAR = 2021
      INPUT_PARSER = lambda { |line| line.split("").map(&:to_i) }

      class << self
        def find_shortest(input, rotate_to=1)
          @rotate_to = rotate_to
          counter = 0
          distances = {}
          edges = {}
          @input = input
          @size = @input.size
          distances[[0, 0]] = 0
          @visited = {}

          def rotate(i, j , value)
            i_offset = i / @size
            j_offset = j / @size
            return 10000000 if [i_offset, j_offset].max > @rotate_to
            value = (value + i_offset + j_offset - 1) % 9 + 1
            value
          end

          def edges(i, j)
            n = []
            n << [i - 1, j] if i > 0
            n << [i + 1, j] if i < @size * @rotate_to - 1
            n << [i, j - 1] if j > 0
            n << [i, j + 1] if j < @size * @rotate_to - 1
            n.map do |x, y|
              [[x, y], rotate(x, y, @input[x % @size][y % @size])] unless @visited[[x, y]]
            end.compact
          end

          t = Time.now
          destination = [@rotate_to * @size - 1, @rotate_to * @size - 1]
          queue = {[0, 0] => 0}
          loop do
            current_node, distance = get_current_node(queue)
            break if current_node == destination
            queue.delete(current_node)
            edges(*current_node).each do |node, edge_distance|
              d = [distance + edge_distance, distances[node] || 10000000000].min
              distances[node] = d
              queue[node] = d
            end
            @visited[current_node] = true
            break if queue.size == 0
            p distance
          end

          p Time.now - t
          distances[destination]
        end

        def get_current_node(queue)
          queue.sort_by { |node, value| value }[0]
        end

        def run_a
          find_shortest(parsed_input)
        end

        def run_b
          find_shortest(parsed_input, 5)
        end
      end
    end
  end
end
