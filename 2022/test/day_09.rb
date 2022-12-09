require_relative "../code/day_09.rb"
require_relative "../../base_test.rb"

class Test20229 < BaseTest
  def day_number
    9
  end

  def year_number
    2022
  end

  def test_run_a
    input_lines([
      "R 4",
      "U 4",
      "L 3",
      "D 1",
      "R 4",
      "D 1",
      "L 5",
      "R 2",
    ])
    assert_equal(13, run_a)
  end

  def test_run_b
    input_lines([
      "R 5",
      "U 8",
      "L 8",
      "D 3",
      "R 17",
      "D 10",
      "L 25",
      "U 20",
    ])
    assert_equal(36, run_b)
  end
end
