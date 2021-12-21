require_relative "../code/day_21.rb"
require_relative "../../base_test.rb"

class Test202121 < BaseTest
  def day_number
    21
  end

  def year_number
    2021
  end

  def test_run_a
    input_lines(["4", "8"])
    assert_equal(739785, run_a)
  end

  def test_run_b
    input_lines(["4", "8"])
    assert_equal(444356092776315, run_b)
  end
end
