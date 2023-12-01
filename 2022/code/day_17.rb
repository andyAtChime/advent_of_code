require_relative '../../day.rb'
require 'set'

module AdventOfCode
  module Year2022
    class AdventOfCode::Year2022::Day17 < AdventOfCode::Day
      DAY = 17
      YEAR = 2022
      INPUT_PARSER = lambda { |line| line.scan(/./)}

      class << self
        def instructions
          @instructions ||= parsed_input[0]
        end

        def blocks
          @blocks ||= {
            0 => {
              ">" => [[4, 0]],
              "<" => [[-1, 0]],
              "down" => [[0, -1], [1, -1], [2, -1], [3, -1]],
              "height" => 0,
              "occupied" => [[0, 0], [1, 0], [2, 0], [3, 0]],
            },
            1 => {
              ">" => [[2, 0], [3, 1], [2, 2]],
              "<" => [[0, 0], [-1, 1], [0, 2]],
              "down" => [[0, 0], [1, -1], [2, 0]],
              "height" => 2,
              "occupied" => [[0, 1], [1, 0], [1, 1], [2, 1], [1, 2]],
            },
            2 => {
              ">" => [[3, 0], [3, 1], [3, 2]],
              "<" => [[-1, 0], [1, 1], [1, 2]],
              "down" => [[0, -1], [1, -1], [2, -1]],
              "height" => 2,
              "occupied" => [[0, 1], [0, 0], [2, 0], [2, 1], [2, 2]],
            },
            3 => {
              ">" => [[1, 0], [1, 1], [1, 2], [1, 3]],
              "<" => [[-1, 0], [-1, 1], [-1, 2], [-1, 3]],
              "down" => [[0, -1]],
              "height" => 3,
              "occupied" => [[0, 0], [0, 1], [0, 2], [0, 3]],
            },
            4 => {
              ">" => [[2, 0], [2, 1]],
              "<" => [[-1, 0], [-1, 1]],
              "down" => [[0, -1], [1, -1]],
              "height" => 1,
              "occupied" => [[0, 0], [0, 1], [1, 1], [1, 0]],
            }
          }
        end

        def debug(occupied, max_height, current = [])
          (8 + max_height).times.map do |i|
            "|" + (7.times.map do |j|
              b = [j, max_height - i + 7]
              if occupied.include?(b)
                "\u2588"
              elsif current.include?(b)
                "\u25a1"
              else
                "."
              end
            end.join) + "|"
          end.to_a
        end

        def run_a
          max_height = 0
          occupied = Set.new
          mov = {"<" => -1, ">" => 1}
          jet_cycle = 0
          jet_cycle_length = instructions.size

          10.times do |b|
            block_pos = [2, max_height + 3]

            while true do
              i = instructions[jet_cycle]
              block_pos[0] += mov[i] if blocks[b % 5][i].all? do |a, b|
                x = block_pos[0] + a
                y = block_pos[1] + b
                x >= 0 && x < 7 && !occupied.include?([x, y])
              end


              can_down = blocks[b % 5]["down"].all? do |a, b|
                x = block_pos[0] + a
                y = block_pos[1] + b
                y >= 0 && !occupied.include?([x, y])
              end

              break if !can_down

              block_pos[1] -= 1
              jet_cycle = (jet_cycle + 1) % jet_cycle_length
            end

            top = block_pos[1] + blocks[b % 5]["height"]
            max_height = top if top > max_height
            a = blocks[b % 5]["occupied"].map { |x| [x[0] + block_pos[0], x[1] + block_pos[1]] }
            a.each { |x| occupied << x }

            puts debug(occupied, max_height, a)

            puts "\n"
          end

          max_height
        end

        def run_b
          # put your code here
        end
      end
    end
  end
end
