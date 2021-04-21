# This file is part of "Prop" project.
#
# This source code is licensed under the MIT license, please view the LICENSE
# file distributed with this source code. For the full
# information and documentation: https://github.com/Nicolab/crystal-prop
# ------------------------------------------------------------------------------

class InitPropClassTest < Testify::Test
  def new_instance
    new_instance(InitPropClass.new)
  end

  def new_instance(str : String)
    new_instance(InitPropClass.new(str))
  end

  def test_instance
    new_instance.should be_a InitPropClass
  end

  # Injects all init tests
  inject_init_tests
end
