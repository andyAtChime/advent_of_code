require_relative "../code/day_17.rb"
require_relative "../../base_test.rb"

class Test202117 < BaseTest
  def day_number
    17
  end

  def year_number
    2021
  end

  def test_run_a
    input_lines(["target area: x=20..30, y=-10..-5"])
    assert_equal(run_a, 45)
  end

  def test_run_b
    input_lines(["target area: x=20..30, y=-10..-5"])
    assert_equal(run_b, 112)
  end
end
