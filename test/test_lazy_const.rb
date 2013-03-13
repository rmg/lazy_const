require 'helper'

$called = 0
class Foo
  extend LazyConst
  lazy_const :TEST do
    $called += 1
    42
  end
end


class TestLazyConst < MiniTest::Unit::TestCase
  def test_lazy_const
    called = 0
    assert_equal $called, 0
    assert_equal Foo.TEST, 42
    assert_equal $called, 1
    assert_equal Foo.TEST, 42
    assert_equal $called, 1
  end
end
