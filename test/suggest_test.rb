require_relative "test_helper"

class TestSuggest < Minitest::Unit::TestCase

  def test_basic
    store_names ["Great White Shark", "Hammerhead Shark", "Tiger Shark"]
    assert_suggest "How Big is a Tigre Shar", "how big is a tiger shark"
  end

  def test_perfect
    store_names ["Tiger Shark", "Great White Shark"]
    assert_suggest "Tiger Shark", nil # no correction
  end

  def test_phrase
    store_names ["Tiger Shark", "Sharp Teeth", "Sharp Mind"]
    assert_suggest "How to catch a tiger shar", "how to catch a tiger shark"
  end

  def test_without_option
    assert_raises(RuntimeError){ Product.search("hi").suggestion }
  end

  protected

  def assert_suggest(term, expected)
    assert_equal expected, Product.search(term, suggest: true).suggestion
  end

end
