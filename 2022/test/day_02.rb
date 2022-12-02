require_relative "../code/day_02.rb"
require_relative "../../base_test.rb"

class Test20222 < BaseTest
  def day_number
    2
  end

  def year_number
    2022
  end

  def test_run_a
    input_lines([
      "A Y",
      "B X",
      "C Z",
    ])
    assert_equal(15, run_a)
  end

  def test_run_b
    input_lines([
      "A Y",
      "B X",
      "C Z",
    ])
    assert_equal(12, run_b)
  end
end
