require_relative '../../day.rb'

module AdventOfCode
  module Year2022
    class AdventOfCode::Year2022::Day07 < AdventOfCode::Day
      DAY = 7
      YEAR = 2022
      INPUT_PARSER = lambda { |line| line }

      class << self
        def directory_sizes
          current_dir = []
          joiner = lambda { |n=current_dir.size| current_dir[(0..n)].join(".") }

          parsed_input.each_with_object(Hash.new(0)) do |line, dir_sizes|
            if /\$ cd (?<dir>.*)/ =~ line
              if dir == ".."
                current_dir.pop
              else
                current_dir << dir
              end
            elsif /(?<size>\d+) (?<file_name>.*)/ =~ line
              (0...current_dir.size).each do |i|
                dir_sizes[joiner.call(i)] += size.to_i
              end
            end
          end
        end

        def run_a
          directory_sizes.values.sort.reject {|k| k >= 100000 }.sum
        end

        def run_b
          sizes = directory_sizes.values
          goal = sizes.max - 40000000
          sizes.reject {|k| k < goal }.min
        end
      end
    end
  end
end
