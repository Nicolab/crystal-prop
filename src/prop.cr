# This file is part of "Prop" project.
#
# This source code is licensed under the MIT license, please view the LICENSE
# file distributed with this source code. For the full
# information and documentation: https://github.com/Nicolab/crystal-prop
# ------------------------------------------------------------------------------

# Prop utilities.
# Mixin module that should be included in a class or a struct.
# This module improves the std's accessor macros (`getter`, `getter!`, `getter?`, `property`, ...).
#
# > See [README](https://github.com/Nicolab/crystal-prop/) for more details and examples.
module Prop
  macro included
    PROPS = {} of String => ASTNode

    macro finished
      {% verbatim do %}
        # Init the props.
        # This method should be called in each `initialize` method,
        # when `Prop` is included in a `class` or a `struct`.
        #
        # ```
        # class Foo
        #   include Prop
        #
        #   # getter ...
        #   # property ...
        #   # define ...
        #
        #   def initialize
        #     init_props
        #   end
        # end
        # ```
        def init_props
          {% for k, prop in PROPS %}
            {% if prop[:block] %}
              {% if prop[:block].args.size > 0 %}
                {{prop[:block].args[0].id}} = {{prop[:default]}}
              {% end %}

              {{prop[:block].body}}
            {% end %}
          {% end %}
        end
      {% end %}
    end

    # Defines a property accessor (`getter`, `property`).
    macro define(macro_name, name, &block)
      {% verbatim do %}
        {% if name.is_a?(TypeDeclaration) %}
          {%
            PROPS["#{@type.name}.#{name.var}"] = {
              name:    name.var,
              type:    name.type,
              default: name.value || "nil".id,
              block:   block,
            }
          %}

          ::{{macro_name}} {{name}}
        {% else %}
          {% raise "#{@type.class}.define doesn't support " + name.class_name %}
        {% end %}
      {% end %}
    end

    macro define(macro_name, name, args)
      {% verbatim do %}
        {% if name.is_a?(TypeDeclaration) %}
          {%
            PROPS["#{@type.name}.#{name.var}"] = {
              name:    name.var,
              type:    name.type,
              default: name.value || "nil".id,
              args:    args,
            }
          %}

          ::{{macro_name}} {{name}}
        {% else %}
          {% raise "#{@type.class}.define doesn't support " + name.class_name %}
        {% end %}
      {% end %}
    end

    macro define(macro_name, name, args, &block)
      {% verbatim do %}
        {% if name.is_a?(TypeDeclaration) %}
          {%
            PROPS["#{@type.name}.#{name.var}"] = {
              name:    name.var,
              type:    name.type,
              default: name.value || "nil".id,
              args:    args,
              block:   block,
            }
          %}

          ::{{macro_name}} {{name}}
        {% else %}
          {% raise "#{@type.class}.define doesn't support " + name.class_name %}
        {% end %}
      {% end %}
    end

    macro property(name, &block)
      define property, \{{name}} \{{block}}
    end

    macro property(name, args)
      define property, \{{name}}, \{{args}}
    end

    macro property(name, args, &block)
      define property, \{{name}}, \{{args}} \{{block}}
    end

    macro getter(name, &block)
      define getter, \{{name}} \{{block}}
    end

    macro getter(name, args)
      define getter, \{{name}}, \{{args}}
    end

    macro getter(name, args, &block)
      define getter, \{{name}}, \{{args}} \{{block}}
    end
  end
end
