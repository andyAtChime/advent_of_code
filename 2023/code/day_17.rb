require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day17 < AdventOfCode::Day
      DAY = 17
      YEAR = 2023
      INPUT_PARSER = lambda { |line| line.split("") }

      class << self

        INVERSE = { u: :d, d: :u, l: :r, r: :l }
        VISUALIZER = { u: "^", d: "v", l: "<", r: ">" }
        def neighbors(node, a)
          x, y, direction, count = node
          [
            [[x, y - 1], :u],
            [[x, y + 1], :d],
            [[x - 1, y], :l],
            [[x + 1, y], :r]
          ].select do |(x, y), d|
            x >= 0 && y >= 0 && x < a.size && y < a.first.size && (direction != d || count < 3) && d != INVERSE[direction]
          end.map do |(x, y), d|
            c = count
            c = 0 if direction != d
            c += 1
            [[x, y, d, c], a[y][x].to_i]
          end.to_h
        end

        def run_a
          a = parsed_input
          start = [0, 0, nil, 0]
          goal = [a.size - 1, a.first.size - 1]
          to_visit = {start => 0}
          visited = {}
          last = {}
          while to_visit.any? do
            key, current_value = to_visit.min_by { |k, v| v }
            x, y, direction, count = key
            visited[key] = to_visit.delete(key)
            break if [x, y] == goal
            neighborinos = neighbors(key, a)
            neighborinos.each do |neighbor, cost|
              next if visited[neighbor]
              to_visit[neighbor] = cost + current_value if !to_visit[neighbor] || to_visit[neighbor] > cost + current_value
              last[neighbor] = key
            end
          end

          goal_key = visited.keys.select { |k| k[0..1] == goal }.first
          k = goal_key
          while k!= start do
            a[k[1]][k[0]] = VISUALIZER[k[2]] || "S"
            k = last[k]
          end
          puts a.map(&:join).join("\n")
          visited[goal_key]
        end

        def run_b
          # put your code here
        end
      end
    end
  end
end
