require_relative "../code/day_13.rb"
require_relative "../../base_test.rb"

class Test202313 < BaseTest
  def day_number
    13
  end

  def year_number
    2023
  end

  def test_run_a
    input_blob(
      <<~INPUT
#.##..##.
..#.##.#.
##......#
##......#
..#.##.#.
..##..##.
#.#.##.#.

#...##..#
#....#..#
..##..###
#####.##.
#####.##.
..##..###
#....#..#
      INPUT
    )
    assert_equal(405, run_a)
  end

  def test_run_b
    input_blob(
      <<~INPUT
#.##..##.
..#.##.#.
##......#
##......#
..#.##.#.
..##..##.
#.#.##.#.

#...##..#
#....#..#
..##..###
#####.##.
#####.##.
..##..###
#....#..#
      INPUT
    )
    assert_equal(400, run_b)
  end
end
