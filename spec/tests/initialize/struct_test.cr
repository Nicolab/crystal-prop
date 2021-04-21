# This file is part of "Prop" project.
#
# This source code is licensed under the MIT license, please view the LICENSE
# file distributed with this source code. For the full
# information and documentation: https://github.com/Nicolab/crystal-prop
# ------------------------------------------------------------------------------

class InitPropStructTest < Testify::Test
  def new_instance
    new_instance(InitPropStruct.new)
  end

  def new_instance(str : String)
    new_instance(InitPropStruct.new(str))
  end

  def test_instance
    new_instance.should be_a InitPropStruct
  end

  # Injects all init tests
  inject_init_tests
end
