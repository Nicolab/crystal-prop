# This file is part of "Prop" project.
#
# This source code is licensed under the MIT license, please view the LICENSE
# file distributed with this source code. For the full
# information and documentation: https://github.com/Nicolab/crystal-prop
# ------------------------------------------------------------------------------

# Prop utilities.
#
# Mixin module that should be included in a class or a struct.
# This module improves the std's accessor macros (`getter`, `getter!`, `getter?`, `property`, ...).
#
# If a block is defined to an instance variable, it will be executed on the
# initialization of the instance (called by each `initialize`).
#
# ```
# property my_var : String = "default value" do |default_value|
#   # Remove leading and trailing whitespace
#   # "    hello    ".strip # => "hello"
#   @my_var = @my_var.strip
# end
# ```
#
# You can provide arguments:
#
# ```
# property my_var : String = "default value", "any type of argument" do |default_value, args|
#   puts args
#   @my_var = @my_var.strip
# end
# ```
#
# The behavior can easily be extended:
#
# ```
# module CustomProp
#   macro included
#     include Prop
#
#     macro finished
#       {% verbatim do %}
#         {% for k, prop in PROPS %}
#           {% if prop[:args] %}
#             some_ioc_method({{prop[:name]}}: { {{prop[:args].double_splat}} })
#           {% end %}
#         {% end %}
#       {% end %}
#     end
#   end
# end
# ```
#
# See [README](https://github.com/Nicolab/crystal-prop/) for more details.
#
# > If you are looking for a validator to validate data before instantiating a class or a struct,
#   you may be interested by [validator](https://github.com/Nicolab/crystal-validator).
#   This [validator](https://github.com/Nicolab/crystal-validator) shard uses `Prop` internally
#   to define and handle validation rules on each instance variable.
module Prop
  macro included
    PROPS = {} of String => ASTNode

    macro finished
      {% verbatim do %}
        # Init the props.
        #
        # This method should be called in each `initialize` method,
        # when `Prop` is included in a `class` or a `struct`.
        #
        # By default `init_props` is __implicitly (automatically) called__ when an instance is created.
        #
        # If you prefer to disable auto-initialization,
        # in order to initialize explicitly in each `initialize` method,
        # you can define `DISABLE_AUTO_INIT_PROPS` constant.
        #
        # Just like that:
        #
        # ```
        # class Foo
        #   DISABLE_AUTO_INIT_PROPS = true
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

              {% if prop[:block].args.size > 1 %}
                {% if prop[:args] %}
                  {{prop[:block].args[1].id}} = {{prop[:args]}}
                {% else %}
                  {{prop[:block].args[1].id}} = nil
                {% end %}
              {% end %}

              {{prop[:block].body}}
            {% end %}
          {% end %}
        end

        {% unless @type.constants.map(&.symbolize).includes?(:DISABLE_AUTO_INIT_PROPS) %}
          {% initialized = false %}
          {% for method in @type.methods %}
            {% if method.name == "initialize" %}
              def initialize({{ method.args.join(",").id }})
                previous_def
                init_props
              end
              {% initialized = true %}
            {% end %}
          {% end %}

          {% unless initialized %}
            def initialize()
              init_props
              {% initialized = true %}
            end

            {% if @type.superclass %}
              def initialize(*args)
                super
                init_props
              end
            {% end %}
          {% end %}
        {% end %}
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
