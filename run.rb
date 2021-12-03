require_relative 'utils'

module RunDay
  class << self
    include AdventOfCode::Utils

    def run(day, year)
      filename = ruby_filename(day, year)
      if File.exist?(filename)
        require filename
      else
        puts "No file found at '#{filename}"
        return
      end
      klass = day_class(day, year)
      [klass.run_a, klass.run_b]
    end
  end
end

year, day = ARGV.map(&:to_i)

puts RunDay.run(day, year)
