# This file is part of "Prop" project.
#
# This source code is licensed under the MIT license, please view the LICENSE
# file distributed with this source code. For the full
# information and documentation: https://github.com/Nicolab/crystal-prop
# ------------------------------------------------------------------------------

# Inject props to test.
macro inject_props
  include PropMixin

  getter nilable : String?
  getter nilable_hooked : String?

  getter nilable_with_args : String?, {str: "a", num: 1}
  getter nilable_with_args_hooked : String?, {str: "b", num: 1}

  getter nilable_with_factory : String? do
    @nilable_with_factory_called = true
  end

  getter nilable_with_factory_hooked : String? do
    @nilable_with_factory_hooked_called = true
  end

  getter with_default : String = "default value"
  getter with_default_hooked : String = "default value"

  getter with_default_and_args : String = "default value with args", {str: "b", num: 2}
  getter with_default_and_args_hooked : String = "default value with args", {str: "b", num: 2}

  getter with_default_and_args_and_factory : String = "default value with args and factory",
    {str: "c", num: 3} do |default_value|
    # should read self
    default_value.should eq "default value with args and factory"
    @with_default_and_args_and_factory.should eq "default value with args and factory"

    # should read the others
    @with_default_and_args.should eq "default value with args"
    @with_default.should eq "default value"
    @nilable_with_factory.should eq nil
    @nilable_with_args.should eq nil
    @nilable.should eq nil

    # should write self
    @with_default_and_args_and_factory = "default value with args and factory hooked by self"

    # should write
    @with_default_and_args_and_factory_hooked = "hook: default value with args and factory hooked"
    @with_default_and_args_hooked = "default value with args hooked"
    @with_default_hooked = "default value hooked"
    @nilable_with_factory_hooked = "nilable_with_factory_hooked"
    @nilable_with_args_hooked = "nilable_with_args_hooked"
    @nilable_hooked = "nilable_hooked"
  end

  getter with_default_and_args_and_factory_hooked : String = "hook: default value with args and factory",
  {str: "c", num: 3} do |default_value|
    # should read self (always the default value)
    default_value.should eq "hook: default value with args and factory"

    # should read updated value
    @with_default_and_args_and_factory.should eq "default value with args and factory hooked by self"

    # should read self (updated from another)
    @with_default_and_args_and_factory_hooked.should eq "hook: default value with args and factory hooked"

    # should write self (updated from another)
    @with_default_and_args_and_factory_hooked = "hook: default value with args and factory rehooked"

    # should write
    @with_default_and_args_and_factory = "default value with args and factory rehooked"
  end
end
