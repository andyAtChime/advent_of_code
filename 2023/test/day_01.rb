require_relative "../code/day_01.rb"
require_relative "../../base_test.rb"

class Test20231 < BaseTest
  def day_number
    1
  end

  def year_number
    2023
  end

  def test_run_a
    input_lines([])
    assert_equal(0, run_a)
  end

  def test_run_b
    input_blob(
      <<~INPUT
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
      INPUT
    )
    assert_equal(281, run_b)
  end
end
