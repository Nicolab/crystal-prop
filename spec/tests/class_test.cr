# This file is part of "Prop" project.
#
# This source code is licensed under the MIT license, please view the LICENSE
# file distributed with this source code. For the full
# information and documentation: https://github.com/Nicolab/crystal-prop
# ------------------------------------------------------------------------------

class PropClassTest < Testify::Test
  def new_instance
    new_instance(PropClass.new)
  end

  def test_instance
    new_instance.should be_a PropClass
  end

  # Injects all tests
  inject_tests
end
