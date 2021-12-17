require_relative "../code/day_15.rb"
require_relative "../../base_test.rb"

class Test202115 < BaseTest
  def day_number
    15
  end

  def year_number
    2021
  end

  def test_run_a
    input_lines([
      "1163751742",
      "1381373672",
      "2136511328",
      "3694931569",
      "7463417111",
      "1319128137",
      "1359912421",
      "3125421639",
      "1293138521",
      "2311944581",
    ])
    assert_equal(run_a, 40)
  end

  def test_run_b
    input_lines([
      "1163751742",
      "1381373672",
      "2136511328",
      "3694931569",
      "7463417111",
      "1319128137",
      "1359912421",
      "3125421639",
      "1293138521",
      "2311944581",
    ])
    assert_equal(run_b, 315)
  end
end
