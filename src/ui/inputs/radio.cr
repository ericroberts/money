require "ecr"
require "../error"
require "./input"

module UI
  module Inputs
    class Radio < Input
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
    end
  end
end
