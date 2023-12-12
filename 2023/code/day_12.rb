require_relative '../../day.rb'

module AdventOfCode
  module Year2023
    class AdventOfCode::Year2023::Day12 < AdventOfCode::Day
      DAY = 12
      YEAR = 2023
      INPUT_PARSER = lambda do |line|
        spring_map, conditions = line.split(' ')
        conditions = conditions.split(',').map(&:to_i)
        Struct.new(:spring_map, :conditions).new(spring_map, conditions)
      end

      class Cacher
        def initialize
          @cache = {}
        end

        def possible_solutions(m, conditions)
          cond = conditions.shift
          # finds all indices of array m that contain sequences of "?" values of length cond
          cache_key = [m, cond, *conditions]
          return  @cache[cache_key] if @cache.key?(cache_key) 
          indices = m.each_char.each_cons(cond + 1).with_index.map do |a, i|
            if m[0...i].match(/#/).nil?
              i if a[0...-1].all? { |c| '#?'.include?(c) } && '.?'.include?(a[-1]) && a.size == cond + 1 && m[(i + cond)..].count("#") <= conditions.sum
            end
          end.compact
          indices += m.each_char.each_cons(cond).with_index.map do |a, i|
            if m[0...i].match(/#/).nil?
              i if a.all? { |c| '#?'.include?(c) } && m.size == cond + i
            end
          end.compact
          return indices.size if conditions.empty?
          return 0 if indices.empty?
          # for each index, replace the values with "#" and recurse
          indices.map do |i|
            remains = m[(i + cond + 1)..]
            remains&.match(/\?|#/) ? possible_solutions(remains, conditions.dup) : 0
          end.sum.tap { |s| @cache[cache_key] = s }
        end

        def expanded_solutions(input, duplication)
          possible_solutions(
            ([input.spring_map] * duplication).join("?"),
            input.conditions.dup * duplication,
          )
        end
      end

      class << self
        def run_a
          c = Cacher.new
          parsed_input.each_with_index.map do |input, i|
            c.possible_solutions(input.spring_map, input.conditions.dup)
          end.sum
        end

        def run_b
          c = Cacher.new
          parsed_input.each_with_index.map do |input, i|
            c.expanded_solutions(input, 5)
          end.sum
        end
      end
    end
  end
end
