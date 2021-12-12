require_relative "../code/day_11.rb"
require_relative "../../base_test.rb"

class Test202111 < BaseTest
  def day_number
    11
  end

  def year_number
    2021
  end

  def test_run_a
    input_lines([
      "5483143223",
      "2745854711",
      "5264556173",
      "6141336146",
      "6357385478",
      "4167524645",
      "2176841721",
      "6882881134",
      "4846848554",
      "5283751526",
    ])
    assert_equal(run_a, 1656)
  end

  def test_run_b
    input_lines([
      "5483143223",
      "2745854711",
      "5264556173",
      "6141336146",
      "6357385478",
      "4167524645",
      "2176841721",
      "6882881134",
      "4846848554",
      "5283751526",
    ])
    assert_equal(run_b, 195)
  end
end
