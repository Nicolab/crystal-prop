# This file is part of "Prop" project.
#
# This source code is licensed under the MIT license, please view the LICENSE
# file distributed with this source code. For the full
# information and documentation: https://github.com/Nicolab/crystal-prop
# ------------------------------------------------------------------------------

class PropStructTest < Testify::Test
  def new_instance
    new_instance(PropStruct.new)
  end

  def test_instance
    new_instance.should be_a PropStruct
  end

  # Injects all tests
  inject_tests
end
