require_relative "../code/day_08.rb"
require_relative "../../base_test.rb"

class Test20228 < BaseTest
  def day_number
    8
  end

  def year_number
    2022
  end

  def test_run_a
    input_lines([
      "30373",
      "25512",
      "65332",
      "33549",
      "35390",
    ])
    assert_equal(0, run_a)
  end

  def test_run_b
    input_lines([
      "30373",
      "25512",
      "65332",
      "33549",
      "35390",
    ])
    assert_equal(0, run_b)
  end
end
