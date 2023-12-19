require_relative "../code/day_17.rb"
require_relative "../../base_test.rb"

class Test202317 < BaseTest
  def day_number
    17
  end

  def year_number
    2023
  end

  def test_run_a
    input_blob(
      <<~INPUT
2413432311323
3215453535623
3255245654254
3446585845452
4546657867536
1438598798454
4457876987766
3637877979653
4654967986887
4564679986453
1224686865563
2546548887735
4322674655533
      INPUT
    )
    assert_equal(0, run_a)
  end

  def test_run_b
    input_blob(
      <<~INPUT
111111111111
999999999991
999999999991
999999999991
999999999991
      INPUT
    )
    assert_equal(0, run_b)
  end
end
