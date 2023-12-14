require_relative "../code/day_14.rb"
require_relative "../../base_test.rb"

class Test202314 < BaseTest
  def day_number
    14
  end

  def year_number
    2023
  end

  def test_run_a
    input_blob(
      <<~INPUT
O....#....
O.OO#....#
.....##...
OO.#O....O
.O.....O#.
O.#..O.#.#
..O..#O..O
.......O..
#....###..
#OO..#....
      INPUT
    )
    assert_equal(136, run_a)
  end

  def test_run_b
    input_blob(
      <<~INPUT
O....#....
O.OO#....#
.....##...
OO.#O....O
.O.....O#.
O.#..O.#.#
..O..#O..O
.......O..
#....###..
#OO..#....
      INPUT
    )
    assert_equal(64, run_b)
  end
end
