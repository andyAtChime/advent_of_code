require_relative "../code/day_16.rb"
require_relative "../../base_test.rb"

class Test202316 < BaseTest
  def day_number
    16
  end

  def year_number
    2023
  end

  def test_run_a
    input_blob(
      <<~'INPUT'
.|...\....
|.-.\.....
.....|-...
........|.
..........
.........\
..../.\\..
.-.-/..|..
.|....-|.\
..//.|....
      INPUT
    )
    assert_equal(0, run_a)
  end

  def test_run_b
    input_blob(
      <<~'INPUT'
.|...\....
|.-.\.....
.....|-...
........|.
..........
.........\
..../.\\..
.-.-/..|..
.|....-|.\
..//.|....
      INPUT
    )
    assert_equal(0, run_b)
  end
end
