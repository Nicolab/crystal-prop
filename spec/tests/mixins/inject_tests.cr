# This file is part of "Prop" project.
#
# This source code is licensed under the MIT license, please view the LICENSE
# file distributed with this source code. For the full
# information and documentation: https://github.com/Nicolab/crystal-prop
# ------------------------------------------------------------------------------

# Injects the tests and the helpers, common to `class` and `struct`.
macro inject_tests
  def proxy_called!(is)
    is.proxy_called.should eq true
    is
  end

  def spy_args!(is, k, expected)
    is.spy_args(k).should eq expected
    is
  end

  def spy_default_value!(is, k, expected)
    is.spy_default_value(k).should eq expected
    is
  end

  def new_instance(is)
    proxy_called!(is)
  end

  # ----------------------------------------------------------------------------

  def test_nilable
    is = new_instance
    spy_default_value!(is, "nilable", nil)
    is.nilable.should be_a String?
    is.nilable.should eq nil
  end

  def test_nilable_hooked
    is = new_instance
    spy_default_value!(is, "nilable_hooked", nil)
    is.nilable_hooked.should be_a String?
    is.nilable_hooked.should eq "nilable_hooked"
  end

  def test_nilable_with_args
    is = new_instance
    spy_default_value!(is, "nilable_with_args", nil)
    spy_args!(is, "nilable_with_args", {str: "a", num: 1})
    is.nilable_with_args.should be_a String?
    is.nilable_with_args.should eq nil
  end

  def test_nilable_with_args_hooked
    is = new_instance
    spy_default_value!(is, "nilable_with_args_hooked", nil)
    spy_args!(is, "nilable_with_args_hooked", {str: "b", num: 1})
    is.nilable_with_args_hooked.should be_a String?
    is.nilable_with_args_hooked.should eq "nilable_with_args_hooked"
  end

  def test_nilable_with_factory
    is = new_instance
    spy_default_value!(is, "nilable_with_factory", nil)
    is.nilable_with_factory_called.should eq true
    is.nilable_with_factory.should be_a String?
    is.nilable_with_factory.should eq nil
  end

  def test_nilable_with_factory_hooked
    is = new_instance
    spy_default_value!(is, "nilable_with_factory_hooked", nil)
    is.nilable_with_factory_hooked_called.should eq true
    is.nilable_with_factory_hooked.should be_a String?
    is.nilable_with_factory_hooked.should eq "nilable_with_factory_hooked"
  end

  def test_with_default
    is = new_instance
    spy_default_value!(is, "with_default", "default value")
    is.with_default.should be_a String?
    is.with_default.should eq "default value"
  end

  def test_with_default_hooked
    is = new_instance
    spy_default_value!(is, "with_default_hooked", "default value")
    is.with_default_hooked.should be_a String?
    is.with_default_hooked.should eq "default value hooked"
  end

  def test_with_default_and_args
    is = new_instance
    spy_default_value!(is, "with_default_and_args", "default value with args")
    spy_args!(is, "with_default_and_args", {str: "b", num: 2})
    is.with_default_and_args.should be_a String?
    is.with_default_and_args.should eq "default value with args"
  end

  def test_with_default_and_args_hooked
    is = new_instance
    spy_default_value!(is, "with_default_and_args_hooked", "default value with args")
    spy_args!(is, "with_default_and_args", {str: "b", num: 2})
    is.with_default_and_args_hooked.should be_a String?
    is.with_default_and_args_hooked.should eq "default value with args hooked"
  end

  def test_with_default_and_args_and_factory
    is = new_instance
    spy_default_value!(is, "with_default_and_args_and_factory", "default value with args and factory")
    spy_args!(is, "with_default_and_args_and_factory", {str: "c", num: 3})
    is.with_default_and_args_and_factory.should be_a String?

    # should be rewritten by self
    is.with_default_and_args_and_factory.should eq "default value with args and factory rehooked"
  end

  def test_with_default_and_args_and_factory_hooked
    is = new_instance
    spy_default_value!(is, "with_default_and_args_and_factory_hooked", "hook: default value with args and factory")
    spy_args!(is, "with_default_and_args_and_factory_hooked", {str: "c", num: 3})
    is.with_default_and_args_and_factory_hooked.should be_a String?
    is.with_default_and_args_and_factory_hooked.should eq "hook: default value with args and factory rehooked"
  end
end
