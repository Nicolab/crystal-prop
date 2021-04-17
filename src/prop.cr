# This file is part of "Prop" project.
#
# This source code is licensed under the MIT license, please view the LICENSE
# file distributed with this source code. For the full
# information and documentation: https://github.com/Nicolab/crystal-prop
# ------------------------------------------------------------------------------

# Prop utilities.
#
# > See [README](https://github.com/Nicolab/crystal-prop/) for more details and examples.
module Prop
  # Mixin module that should be included in a class or a struct.
  # This module improves the std's `getter` macro.
  module Getter
    macro included
      PROPS = {} of String => ASTNode

      macro finished
        {% verbatim do %}
          def initialize
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

      macro getter(name, &block)
        {% verbatim do %}
          {% if name.is_a?(TypeDeclaration) %}
            {% PROPS["#{@type.name}.#{name.var}"] = {
                 name:    name.var,
                 type:    name.type,
                 default: name.value || "nil".id,
                 block:   block,
               } %}

            @{{name.var}} : {{name.type}}{% if name.value %} = {{name.value}}{% end %}

            def {{name.var}} : {{name.type}}
              @{{name.var}}
            end
          {% else %}
            {% raise "#{@type.class}.getter doesn't support " + name.class_name %}
          {% end %}
        {% end %}
      end

      macro getter(name, args)
        {% verbatim do %}
          {% if name.is_a?(TypeDeclaration) %}
            {% PROPS["#{@type.name}.#{name.var}"] = {
                 name:    name.var,
                 type:    name.type,
                 default: name.value || "nil".id,
                 args:    args,
               } %}

            @{{name.var}} : {{name.type}}{% if name.value %} = {{name.value}}{% end %}

            def {{name.var}} : {{name.type}}
              @{{name.var}}
            end
          {% else %}
            {% raise "#{@type.class}.entry doesn't support " + name.class_name %}
          {% end %}
        {% end %}
      end

      macro getter(name, args, &block)
        {% verbatim do %}
          {% if name.is_a?(TypeDeclaration) %}
            {% PROPS["#{@type.name}.#{name.var}"] = {
                 name:    name.var,
                 type:    name.type,
                 default: name.value || "nil".id,
                 args:    args,
                 block:   block,
               } %}

            @{{name.var}} : {{name.type}}{% if name.value %} = {{name.value}}{% end %}

            def {{name.var}} : {{name.type}}
              @{{name.var}}
            end
          {% else %}
            {% raise "#{@type.class}.entry doesn't support " + name.class_name %}
          {% end %}
        {% end %}
      end
    end
  end
end
