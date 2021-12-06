require_relative "../code/day_06.rb"
require_relative "../../base_test.rb"

class Test20216 < BaseTest
  def day_number
    6
  end

  def year_number
    2021
  end

  def test_run_a
    input_lines(['3,4,3,1,2'])
    assert_equal(run_a, 5934)
  end

  def test_run_b
    input_lines(['3,4,3,1,2'])
    assert_equal(run_b, 26984457539)
  end
end
