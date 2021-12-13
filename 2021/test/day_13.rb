require_relative "../code/day_13.rb"
require_relative "../../base_test.rb"

class Test202113 < BaseTest
  def day_number
    13
  end

  def year_number
    2021
  end

  def test_run_a
    input_lines([
      "6,10",
      "0,14",
      "9,10",
      "0,3",
      "10,4",
      "4,11",
      "6,0",
      "6,12",
      "4,1",
      "0,13",
      "10,12",
      "3,4",
      "3,0",
      "8,4",
      "1,10",
      "2,14",
      "8,10",
      "9,0",
      "",
      "fold along y=7",
      "fold along x=5",
    ])
    assert_equal(run_a, 17)
  end

  def test_run_b
    input_lines([
      "6,10",
      "0,14",
      "9,10",
      "0,3",
      "10,4",
      "4,11",
      "6,0",
      "6,12",
      "4,1",
      "0,13",
      "10,12",
      "3,4",
      "3,0",
      "8,4",
      "1,10",
      "2,14",
      "8,10",
      "9,0",
      "",
      "fold along y=7",
      "fold along x=5",
    ])
    assert_equal(
      run_b,
      "XXXXXXXXXX\nXX      XX\nXX      XX\nXX      XX\nXXXXXXXXXX\n"
    )
  end
end
