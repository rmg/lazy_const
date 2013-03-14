require 'helper'

$called = 0
class Foo
  extend LazyConst
  lazy_const :TEST do
    $called += 1
    new 42
  end
  attr_reader :number
  def initialize(number)
    @number = number
  end
end


class TestLazyConst < MiniTest::Unit::TestCase

  def setup
    $called = 0
  end

  def test_lazy_const
    assert_equal $called, 0
    obj = Foo.TEST
    assert_equal obj, Foo.TEST
    assert_equal $called, 1
    assert_equal obj, Foo.TEST
    assert_equal $called, 1
  end

  def test_preload
    assert_equal $called, 0
    LazyConst.preload
    assert_equal $called, 1
    obj = Foo.TEST
    assert_equal obj, Foo.TEST
  end
end
