require_relative "../code/day_14.rb"
require_relative "../../base_test.rb"

class Test202214 < BaseTest
  def day_number
    14
  end

  def year_number
    2022
  end

  def test_run_a
    input_lines([
      "498,4 -> 498,6 -> 496,6",
      "503,4 -> 502,4 -> 502,9 -> 494,9",
    ])
    assert_equal(0, run_a)
  end

  def test_run_b
    input_lines([
      "498,4 -> 498,6 -> 496,6",
      "503,4 -> 502,4 -> 502,9 -> 494,9",
    ])
    assert_equal(0, run_b)
  end
end
