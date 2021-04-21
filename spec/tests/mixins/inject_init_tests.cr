# This file is part of "Prop" project.
#
# This source code is licensed under the MIT license, please view the LICENSE
# file distributed with this source code. For the full
# information and documentation: https://github.com/Nicolab/crystal-prop
# ------------------------------------------------------------------------------

# Injects the tests and the helpers, common to `class` and `struct`.
macro inject_init_tests
  def new_instance(is)
    is
  end

  def test_new_instance_without_args
    is = new_instance
    is.str.should eq nil
    is.str_with_args_block_called.should eq true
    is.str_with_args_hooked_block_called.should eq true
    is.@str_with_args_hooked.should eq "hooked!"
  end

  def test_new_instance_with_args
    is = new_instance("hello")
    is.str.should eq "hello"
    is.str_with_args_block_called.should eq true
    is.str_with_args_hooked_block_called.should eq true
    is.@str_with_args_hooked.should eq "hooked!"
  end
end
