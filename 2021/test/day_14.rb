require_relative "../code/day_14.rb"
require_relative "../../base_test.rb"

class Test202114 < BaseTest
  def day_number
    14
  end

  def year_number
    2021
  end

  def test_run_a
    input_lines([
      "NNCB",
      "",
      "CH -> B",
      "HH -> N",
      "CB -> H",
      "NH -> C",
      "HB -> C",
      "HC -> B",
      "HN -> C",
      "NN -> C",
      "BH -> H",
      "NC -> B",
      "NB -> B",
      "BN -> B",
      "BB -> N",
      "BC -> B",
      "CC -> N",
      "CN -> C",
    ])
    assert_equal(run_a, 1588)
  end

  def test_run_b
    input_lines([
      "NNCB",
      "",
      "CH -> B",
      "HH -> N",
      "CB -> H",
      "NH -> C",
      "HB -> C",
      "HC -> B",
      "HN -> C",
      "NN -> C",
      "BH -> H",
      "NC -> B",
      "NB -> B",
      "BN -> B",
      "BB -> N",
      "BC -> B",
      "CC -> N",
      "CN -> C",
    ])
    assert_equal(run_b, 2188189693529)
  end
end
