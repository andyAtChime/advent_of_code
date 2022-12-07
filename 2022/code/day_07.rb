require_relative '../../day.rb'

module AdventOfCode
  module Year2022
    class AdventOfCode::Year2022::Day07 < AdventOfCode::Day
      DAY = 7
      YEAR = 2022
      INPUT_PARSER = lambda { |line| line }

      class << self
        def get_size(dirs, dir)
          dirs[dir][:file_size] + dirs[dir][:subs].map { |s| get_size(dirs, s) }.sum
        end

        def directory_sizes
          directories = {"/" => {file_size: 0, subs: []}}
          current_dir = ["/"]
          parsed_input.each do |line|
            if /\$ cd ?(?<dir>.*)/ =~ line
              if dir == ".."
                current_dir.pop if current_dir.length > 1
              elsif dir == "/"
                current_dir = ["/"]
              else
                current_dir << dir
              end
            elsif /\$ ls/ =~ line
            else
              dir = current_dir.join("/")
              if /dir (?<subdir>.*)/ =~ line
                subdir = dir + "/" + subdir
                directories[subdir] = {file_size: 0, subs: []} unless directories[subdir]
                directories[dir][:subs] << subdir
              elsif /(?<size>\d+) (?<filename>.*)/ =~ line
                directories[dir][:file_size] += size.to_i
              end
            end
          end

          {}.tap do |dir_sizes|
            directories.each do |dir, v| 
              dir_sizes[dir] = get_size(directories, dir)
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
