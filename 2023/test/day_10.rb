require_relative "../code/day_10.rb"
require_relative "../../base_test.rb"

class Test202310 < BaseTest
  def day_number
    10
  end

  def year_number
    2023
  end

  def test_run_a
    input_blob(
      <<~INPUT
..F7.
.FJ|.
SJ.L7
|F--J
LJ...
      INPUT
    )
    assert_equal(8, run_a)
  end

  def test_run_b
    input_blob(
      <<~INPUT
FF7FSF7F7F7F7F7F---7
L|LJ||||||||||||F--J
FL-7LJLJ||||||LJL-77
F--JF--7||LJLJ7F7FJ-
L---JF-JLJ.||-FJLJJ7
|F|F-JF---7F7-L7L|7|
|FFJF7L7F-JF7|JL---7
7-L-JL7||F7|L7F-7F7|
L.L7LFJ|||||FJL7||LJ
L7JLJL-JLJLJL--JLJ.L
      INPUT
    )
    assert_equal(10, run_b)
  end
end
