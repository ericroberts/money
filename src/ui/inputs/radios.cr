require "ecr"
require "../error"
require "./input"
require "./radio"

module UI
  module Inputs
    class Radios < Input
      def initialize(
        value : String,
        error : UI::ErrorI,
        label : String,
        name : Symbol,
        options : Array(Symbol),
      )
        @value = value
        @error = error
        @label = label
        @name = name
        @options = options
      end

      getter :label
      private getter :value, :name, :options

      ECR.def_to_s "./src/ui/inputs/radios.ecr"

      def render
        to_s
      end

      def radios
        options.map do |option|
          Radio.new(
            value: option.to_s,
            label: option.to_s, # TODO: Replace with strings
            name: name,
            checked: value == option.to_s,
          )
        end
      end
    end
  end
end
