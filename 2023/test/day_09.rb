require_relative "../code/day_09.rb"
require_relative "../../base_test.rb"

class Test20239 < BaseTest
  def day_number
    9
  end

  def year_number
    2023
  end

  def test_run_a
    input_blob(
      <<~INPUT
0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45        
      INPUT
    )
    assert_equal(114, run_a)
  end

  def test_run_b
    input_blob(
      <<~INPUT
0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45        
      INPUT
    )
    assert_equal(2, run_b)
  end
end
