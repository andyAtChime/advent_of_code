require_relative "../code/day_03.rb"
require_relative "../../base_test.rb"

class Test20213 < BaseTest
  def day_number
    3
  end

  def year_number
    2021
  end

  def test_run_a
    input_lines(
      [
        "00100",
        "11110",
        "10110",
        "10111",
        "10101",
        "01111",
        "00111",
        "11100",
        "10000",
        "11001",
        "00010",
        "01010",
      ]
    )
    assert_equal(run_a, 198)
  end

  def test_run_b
    input_lines(
      [
        "00100",
        "11110",
        "10110",
        "10111",
        "10101",
        "01111",
        "00111",
        "11100",
        "10000",
        "11001",
        "00010",
        "01010",
      ]
    )
    assert_equal(run_b, 23)
  end
end
