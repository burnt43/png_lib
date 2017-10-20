require './test/test_helper'

class NullTest < MiniTest::Test
  def test_foo
    assert(true)
  end
  def test_debug
    Png::Image.create_from_filename('./test/assets/test_image_0000.png')
  end
end
