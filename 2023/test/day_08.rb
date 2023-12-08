require_relative "../code/day_08.rb"
require_relative "../../base_test.rb"

class Test20238 < BaseTest
  def day_number
    8
  end

  def year_number
    2023
  end

  def test_run_a
    input_blob(
      <<~INPUT
LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)        
      INPUT
    )
    assert_equal(6, run_a)
  end

  def test_run_b
    input_blob(
      <<~INPUT
LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)        
      INPUT
    )
    assert_equal(0, run_b)
  end
end
