require "test/unit"
require_relative "./utils.rb"

class BaseTest < Test::Unit::TestCase
  include AdventOfCode::Utils

  def input_lines(input)
    @input_lines = input
  end

  def input_blob(input)
    @input_blob = input
  end

  def mock_day
    d = day_class(day_number, year_number)
    d.input_lines = @input_lines
    d.input_blob = @input_blob
    d
  end

  def run_a
    mock_day.run_a
  end

  def run_b
    mock_day.run_b
  end
end
