require_relative "../code/day_02.rb"
require_relative "../../base_test.rb"

class TestDay2 < BaseTest
  def day_number
    2
  end

  def year_number
    2021
  end

  def test_run_a
    input_lines([
      "forward 5",
      "down 5",
      "forward 8",
      "up 3",
      "down 8",
      "forward 2",
    ])
    assert_equal(run_a, 150)
  end

  def test_run_b
    input_lines([
      "forward 5",
      "down 5",
      "forward 8",
      "up 3",
      "down 8",
      "forward 2",
    ])
    assert_equal(run_b, 900)
  end
end
