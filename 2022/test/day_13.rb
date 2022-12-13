require_relative "../code/day_13.rb"
require_relative "../../base_test.rb"

class Test202213 < BaseTest
  def day_number
    13
  end

  def year_number
    2022
  end

  def test_run_a
    input_lines([
      "[1,1,3,1,1]",
      "[1,1,5,1,1]",
      "",
      "[[1],[2,3,4]]",
      "[[1],4]",
      "",
      "[9]",
      "[[8,7,6]]",
      "",
      "[[4,4],4,4]",
      "[[4,4],4,4,4]",
      "",
      "[7,7,7,7]",
      "[7,7,7]",
      "",
      "[]",
      "[3]",
      "",
      "[[[]]]",
      "[[]]",
      "",
      "[1,[2,[3,[4,[5,6,7]]]],8,9]",
      "[1,[2,[3,[4,[5,6,0]]]],8,9]",
      "",
    ])
    assert_equal(13, run_a)
  end

  def test_run_b
    input_lines([])
    assert_equal(0, run_b)
  end
end
