require_relative '../../day.rb'
require 'set'

module AdventOfCode
  module Year2022
    class AdventOfCode::Year2022::Day14 < AdventOfCode::Day
      DAY = 14
      YEAR = 2022
      INPUT_PARSER = lambda do |line|
        line.split(" -> ").map { |x| x.split(",").map(&:to_i) }
      end

      class << self
        def run_a
          filled = {}

          ys = Set.new
          parsed_input.each do |line|
            line.each_cons(2).each do |a, b|
              if a[0] == b[0]
                c = [a[1], b[1]].sort
                (c[0]..c[1]).each { |i| filled[[a[0], i]] = true }
              else
                c = [a[0], b[0]].sort
                (c[0]..c[1]).each { |i| filled[[i, a[1]]] = true }
                ys << a[1]
                ys << b[1]
              end
            end
          end

          ymax = ys.to_a.max

          sands = 0

          while sands < 100000
            sands += 1
            x, y = 500, 0
            while !(filled[[x, y+1]] && filled[[x+1, y+1]] && filled[[x-1, y+1]])
              if !filled[[x, y+1]]
                y += 1
                return sands - 1 if y > ymax + 10
              elsif !filled[[x-1, y+1]]
                y += 1
                x -= 1
              elsif !filled[[x+1, y+1]]
                y += 1
                x += 1
              end
            end
            filled[[x, y]] = true
            
          end
          return sands - 1
        end

        def run_b
          filled = {}

          ys = Set.new
          xs = Set.new
          parsed_input.each do |line|
            line.each_cons(2).each do |a, b|
              if a[0] == b[0]
                c = [a[1], b[1]].sort
                (c[0]..c[1]).each { |i| filled[[a[0], i]] = true }
                xs << a[0]
                xs << a[0]
              else
                c = [a[0], b[0]].sort
                (c[0]..c[1]).each { |i| filled[[i, a[1]]] = true }
                ys << a[1]
                ys << b[1]
              end
            end
          end

          ymax = ys.to_a.max

          ((500 - ymax - 10)..(500 + ymax + 10)).each do |i|
            filled[[i, ymax + 2]] = true 
          end

          sands = 0
          while sands < 100000
            sands += 1
            x, y = 500, 0
            while true
              if !filled[[x, y+1]]
                y += 1
              elsif !filled[[x-1, y+1]]
                y += 1
                x -= 1
              elsif !filled[[x+1, y+1]]
                y += 1
                x += 1
              else
                break
              end
            end

            return sands if x == 500 && y == 0
            filled[[x, y]] = true
            
          end
          return sands - 1
        end
      end
    end
  end
end
