require_relative "../code/day_16.rb"
require_relative "../../base_test.rb"

class Test202116 < BaseTest
  def day_number
    16
  end

  def year_number
    2021
  end

  def test_run_a_1
    input_lines(['8A004A801A8002F478'])
    assert_equal(run_a, 16)
  end

  def test_run_a_2
    input_lines(['620080001611562C8802118E34'])
    assert_equal(run_a, 12)
  end

  def test_run_a_3
    input_lines(['C0015000016115A2E0802F182340'])
    assert_equal(run_a, 23)
  end

  def test_run_a_4
    input_lines(['A0016C880162017C3686B18A3D4780'])
    assert_equal(run_a, 31)
  end

  def test_run_b_1
    input_lines(['C200B40A82'])
    assert_equal(run_b, 3)
  end

  def test_run_b_2
    input_lines(['04005AC33890'])
    assert_equal(run_b, 54)
  end

  def test_run_b_3
    input_lines(['880086C3E88112'])
    assert_equal(run_b, 7)
  end

  def test_run_b_4
    input_lines(['CE00C43D881120'])
    assert_equal(run_b, 9)
  end

  def test_run_b_5
    input_lines(['D8005AC2A8F0'])
    assert_equal(run_b, 1)
  end

  def test_run_b_6
    input_lines(['F600BC2D8F'])
    assert_equal(run_b, 0)
  end

  def test_run_b_7
    input_lines(['9C005AC2F8F0'])
    assert_equal(run_b, 0)
  end

  def test_run_b_8
    input_lines(['9C0141080250320F1802104A08'])
    assert_equal(run_b, 1)
  end
end
