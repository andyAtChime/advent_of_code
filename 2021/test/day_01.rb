require_relative "../code/day_01.rb"
require_relative "../../base_test.rb"

class TestDay1 < BaseTest
  def day_number
    1
  end

  def year_number
    2021
  end

  def test_monotonic_increase
    input_lines([1, 2, 3, 4])
    assert_equal(run_a, 3)
  end

  def test_flat_spot
    input_lines([1, 2, 2, 4])
    assert_equal(run_a, 2)
  end

  def test_dip
    input_lines([1, 2, 1, 4])
    assert_equal(run_a, 2)
  end

  def test_all_down
    input_lines([4, 3, 2, 1])
    assert_equal(run_a, 0)
  end

  def test_two_dips
    input_lines([2, 1, 3, 2,])
    assert_equal(run_a, 1)
  end

  def test_example_a
    input_lines([199, 200, 208, 210, 200, 207, 240, 269, 260, 263])
    assert_equal(run_a, 7)
  end

  def test_example_b
    input_lines([199, 200, 208, 210, 200, 207, 240, 269, 260, 263])
    assert_equal(run_b, 5)
  end
end
