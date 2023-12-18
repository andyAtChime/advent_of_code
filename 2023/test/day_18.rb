require_relative "../code/day_18.rb"
require_relative "../../base_test.rb"

class Test202318 < BaseTest
  def day_number
    18
  end

  def year_number
    2023
  end

  def test_run_a
    input_blob(
      <<~INPUT
R 6 (#70c710)
D 5 (#0dc571)
L 2 (#5713f0)
D 2 (#d2c081)
R 2 (#59c680)
D 2 (#411b91)
L 5 (#8ceee2)
U 2 (#caa173)
L 1 (#1b58a2)
U 2 (#caa171)
R 2 (#7807d2)
U 3 (#a77fa3)
L 2 (#015232)
U 2 (#7a21e3)
      INPUT
    )
    assert_equal(62, run_a)
  end

  def test_run_b
    input_blob(
      <<~INPUT
R 6 (#70c710)
D 5 (#0dc571)
L 2 (#5713f0)
D 2 (#d2c081)
R 2 (#59c680)
D 2 (#411b91)
L 5 (#8ceee2)
U 2 (#caa173)
L 1 (#1b58a2)
U 2 (#caa171)
R 2 (#7807d2)
U 3 (#a77fa3)
L 2 (#015232)
U 2 (#7a21e3)
      INPUT
    )
    assert_equal(952408144115, run_b)
  end
end
