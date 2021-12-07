require_relative "../code/day_07.rb"
require_relative "../../base_test.rb"

class Test20217 < BaseTest
  def day_number
    7
  end

  def year_number
    2021
  end

  def test_run_a
    input_lines(["16,1,2,0,4,2,7,1,2,14"])
    assert_equal(run_a, 37)
  end

  def test_run_b
    input_lines(["16,1,2,0,4,2,7,1,2,14"])
    assert_equal(run_b, 168)
  end
end
