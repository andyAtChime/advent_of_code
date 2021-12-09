require_relative "../code/day_09.rb"
require_relative "../../base_test.rb"

class Test20219 < BaseTest
  def day_number
    9
  end

  def year_number
    2021
  end

  def test_run_a
    input_lines([
      "2199943210",
      "3987894921",
      "9856789892",
      "8767896789",
      "9899965678",
    ])
    assert_equal(run_a, 15)
  end

  def test_run_b
    input_lines([
      "2199943210",
      "3987894921",
      "9856789892",
      "8767896789",
      "9899965678",
    ])
    assert_equal(run_b, 1134)
  end
end
