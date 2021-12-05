require_relative "../code/day_05.rb"
require_relative "../../base_test.rb"

class Test20215 < BaseTest
  def day_number
    5
  end

  def year_number
    2021
  end

  def test_run_a
    input_lines([
      "0,9 -> 5,9",
      "8,0 -> 0,8",
      "9,4 -> 3,4",
      "2,2 -> 2,1",
      "7,0 -> 7,4",
      "6,4 -> 2,0",
      "0,9 -> 2,9",
      "3,4 -> 1,4",
      "0,0 -> 8,8",
      "5,5 -> 8,2",
    ])
    assert_equal(run_a, 5)
  end

  def test_run_b
    input_lines([
      "0,9 -> 5,9",
      "8,0 -> 0,8",
      "9,4 -> 3,4",
      "2,2 -> 2,1",
      "7,0 -> 7,4",
      "6,4 -> 2,0",
      "0,9 -> 2,9",
      "3,4 -> 1,4",
      "0,0 -> 8,8",
      "5,5 -> 8,2",
    ])
    assert_equal(run_b, 12)
  end
end
