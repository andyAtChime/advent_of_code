require_relative 'utils'


module TestExec
  class << self
    include AdventOfCode::Utils

    def run_tests(day, year)
      filename = test_filename(day, year)
      if File.exist?(filename)
        require filename
      else
        puts "No file found at '#{filename}"
      end
    end
  end
end

year, day = ARGV.map(&:to_i)
TestExec.run_tests(day, year)
