require "ecr"
require "../error"
require "./input"
require "./radio"
require "../../forms/properties/options_list"

module UI
  module Inputs
    class Radios(S) < InputI
      def initialize(
        value : String,
        error : UI::ErrorI,
        label : String,
        name : Symbol,
        strings : S,
        options : Array(Symbol),
      )
        @value = value
        @error = error
        @label = label
        @name = name
        @strings = strings
        @options = options
      end

      private getter :value, :name, :strings, :options

      ECR.def_to_s "./src/ui/inputs/radios.ecr"

      def label
        strings[:label]
      end

      def render
        to_s
      end

      def radios
        options.map do |option|
          Radio.new(
            value: option.to_s,
            label: strings[:fields][option][:label],
            name: name,
            checked: value == option.to_s,
          )
        end
      end
    end
  end
end
