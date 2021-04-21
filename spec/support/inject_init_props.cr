# This file is part of "Prop" project.
#
# This source code is licensed under the MIT license, please view the LICENSE
# file distributed with this source code. For the full
# information and documentation: https://github.com/Nicolab/crystal-prop
# ------------------------------------------------------------------------------

# Inject props to test.
macro inject_init_props
  include PropMixin

  getter str_with_args : String?, {str: "a", num: 1} do |default_value, args|
    @str_with_args_block_called = true
    @str_with_args_hooked = "hooked!"
    default_value.should eq nil
    args.should eq({str: "a", num: 1})
  end

  getter str_with_args_hooked : String?, {str: "b", num: 2} do |default_value, args|
    @str_with_args_hooked_block_called = true
    default_value.should eq nil
    args.should eq({str: "b", num: 2})

    @str_with_args_hooked.should eq "hooked!"
  end

  getter str_with_args_hooked_block_called : Bool = false
  getter str_with_args_block_called : Bool = false

  def initialize
  end

  def initialize(@str : String? = nil)
  end

  def str
    @str
  end
end
