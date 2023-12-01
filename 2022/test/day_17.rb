require_relative "../code/day_17.rb"
require_relative "../../base_test.rb"

class Test202217 < BaseTest
  def day_number
    17
  end

  def year_number
    2022
  end

  def test_run_a
    input_lines([">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>"])
    assert_equal(0, run_a)
  end

  def test_run_b
    input_lines([])
    assert_equal(0, run_b)
  end
end
