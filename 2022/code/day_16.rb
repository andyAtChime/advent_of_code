require_relative '../../day.rb'

module AdventOfCode
  module Year2022
    class AdventOfCode::Year2022::Day16 < AdventOfCode::Day
      DAY = 16
      YEAR = 2022
      INPUT_PARSER = lambda do |line|
        {
          name: line[6..7],
          rate: line.split("=")[1].split(";")[0].to_i,
          valves: line.split(/valves? /)[1].split(", "),
        }
      end

      class << self
        def valves
          @valves ||= parsed_input.map {|v| [v[:name], v]}.to_h
        end

        def distances(a)
          d = 0
          current_options = a[:valves]
          distances = {}
          while true
            next_options = []
            d += 1
            return distances if current_options == []

            current_options.each do |v|
              if !distances.include?(v) && v != a[:name]
                distances[v] = d
                next_options += valves[v][:valves]
              end
            end

            current_options = next_options
          end
        end

        def max_flow(location, dds, distance_sets, timer = 30)
          if timer < 0 || dds.size == 0
            return 0
          end
          dds.map do |k, v|
            future_time = timer - distance_sets[location][k] - 1
            current_val = future_time * valves[k][:rate]
            sub_flow = max_flow(
              k,
              dds.dup.tap {|d| d.delete(k)},
              distance_sets,
              future_time,
            )
            (sub_flow || 0) + current_val
          end.max  
        end

        def run_a
          desirable_destinations = valves.select { |k, v| v[:rate] > 0 || k == "AA" }.to_h
          distance_sets = Hash.new()
          desirable_destinations.each do |k, v|
            distance_sets[k] = distances(v).select { |k, v| desirable_destinations.include?(k) }
          end
          dds = desirable_destinations.tap {|d| d.delete("AA")}
          max_flow("AA", dds, distance_sets)
        end

        def run_b
          # put your code here
        end
      end
    end
  end
end
