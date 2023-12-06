require_relative "../code/day_06.rb"
require_relative "../../base_test.rb"

class Test20236 < BaseTest
  def day_number
    6
  end

  def year_number
    2023
  end

  def test_run_a
    input_blob(
      <<~INPUT
        Time:      7  15   30
        Distance:  9  40  200        
      INPUT
    )
    assert_equal(288, run_a)
  end

  def test_run_b
    input_blob(
      <<~INPUT
        Time:      7  15   30
        Distance:  9  40  200        
      INPUT
    )
    assert_equal(71503, run_b)
  end
end
