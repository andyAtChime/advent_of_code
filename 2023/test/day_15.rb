require_relative "../code/day_15.rb"
require_relative "../../base_test.rb"

class Test202315 < BaseTest
  def day_number
    15
  end

  def year_number
    2023
  end

  def test_run_a
    input_blob(
      <<~INPUT
rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
      INPUT
    )
    assert_equal(0, run_a)
  end

  def test_run_b
    input_blob(
      <<~INPUT
rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
      INPUT
    )
    assert_equal(0, run_b)
  end
end
