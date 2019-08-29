require "ecr"
require "../error"
require "./input"

module UI
  module Inputs
    class Radio
      def initialize(
        value : String,
        label : String,
        name : String | Symbol,
        checked : Bool
      )
        @value = value
        @label = label
        @name = name
        @checked = checked
      end

      getter :value, :label, :name, :checked

      ECR.def_to_s "./src/ui/inputs/radio.ecr"

      def render
        to_s
      end
    end
  end
end
