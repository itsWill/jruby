require 'test/unit'

# Test that core class methods are correctly raising errors for incorrect call
# arities.
class TestFormat < Test::Unit::TestCase
  # Test Case based on https://github.com/jruby/jruby/issues/5556
  def test_sprintf_one
    n = 97.65625
    s = format("%f %f %.1f", n, n.round(1), n).to_s
    assert(s === "97.656250 97.700000 97.7", "Test failed, value of #{s} did not match '97.656250 97.700000 97.7'.")
  end
  
  def test_sprintf_two
    n = 1234567892.0
    s = format("%01.0f", n).to_s
    assert(s === "1234567892", "Test failed, value of #{s} did not match '1234567892'.")
  end

  def test_round_half_even
    assert_equal("5.00", sprintf("%.2f",5.005))
    assert_equal("5.01", sprintf("%.2f",5.0059))
    assert_equal("5.01", sprintf("%.2f",5.0051))
    assert_equal("5.00", sprintf("%.2f",5.0050))
    assert_equal("5.01", sprintf("%.2f",5.00501))
    assert_equal("5.000", sprintf("%.3f",5.0005))

    assert_equal("5.02", sprintf("%.2f",5.015))
    assert_equal("5.02", sprintf("%.2f",5.025))

    assert_equal("97.66A", "%.2fA" % 97.6562)
    assert_equal("29.56B", "%.2fB" % 29.5562)

    assert_equal "28.554", sprintf("%.3f", 28.5535)
    assert_equal "97.7X", sprintf("%.1fX", 97.65625)

    assert_equal("28.554", "%.3f" % 28.5535)
    assert_equal("97.7X", "%.1fX" % 97.65625)
  end
end

