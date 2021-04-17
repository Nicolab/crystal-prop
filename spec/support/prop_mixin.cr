# This file is part of "Prop" project.
#
# This source code is licensed under the MIT license, please view the LICENSE
# file distributed with this source code. For the full
# information and documentation: https://github.com/Nicolab/crystal-prop
# ------------------------------------------------------------------------------

# Mixin support.
module PropMixin
  @nilable_with_factory_called = false
  @nilable_with_factory_hooked_called = false

  def nilable_with_factory_called : Bool
    @nilable_with_factory_called
  end

  def nilable_with_factory_hooked_called : Bool
    @nilable_with_factory_hooked_called
  end

  macro included
    include Prop

    macro finished
      @proxy_called = true

      {% verbatim do %}
        @spy_args = {
          {% for k, prop in PROPS %}
            {% if prop[:args] %}
              {{k}}: {{prop[:args]}},
            {% end %}
          {% end %}
        }

        @spy_default_value = {
          {% for k, prop in PROPS %}
            {% if prop[:default] %}
              {{k}}: {{prop[:default]}},
            {% end %}
          {% end %}
        }
      {% end %}

      def proxy_called
        @proxy_called
      end

      def spy_args(k : String)
        @spy_args["{{@type.name}}.#{k}"]
      end

      def spy_args
        @spy_args
      end

      def spy_default_value(k : String)
        @spy_default_value["{{@type.name}}.#{k}"]
      end

      def spy_default_value
        @spy_default_value
      end
    end
  end
end
