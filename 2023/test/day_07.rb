require_relative "../code/day_07.rb"
require_relative "../../base_test.rb"

class Test20237 < BaseTest
  def day_number
    7
  end

  def year_number
    2023
  end

  def test_run_a
    input_blob(
      <<~INPUT
        32T3K 765
        T55J5 684
        KK677 28
        KTJJT 220
        QQQJA 483        
      INPUT
    )
    assert_equal(0, run_a)
  end

  def test_run_b
    input_blob(
      <<~INPUT
        32T3K 765
        T55J5 684
        KK677 28
        KTJJT 220
        QQQJA 483        
      INPUT
    )
    assert_equal(0, run_b)
  end
end
