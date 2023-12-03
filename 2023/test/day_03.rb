require_relative "../code/day_03.rb"
require_relative "../../base_test.rb"

class Test20233 < BaseTest
  def day_number
    3
  end

  def year_number
    2023
  end

  def test_run_a
    input_blob(
      <<~INPUT
        467..114..
        ...*......
        ..35..633.
        ......#...
        617*......
        .....-.58.
        ..592.....
        ......755.
        ...$.*....
        .664.598..
      INPUT
    )
    assert_equal(4361, run_a)
  end

  def test_run_b
    input_blob(
      <<~INPUT
        467..114..
        ...*......
        ..35..633.
        ......#...
        617*......
        .....-.58.
        ..592.....
        ......755.
        ...$.*....
        .664.598..
      INPUT
    )
    assert_equal(467835, run_b)
  end
end
