require "ecr"
require "../error"
require "./input"

module UI
  module Inputs
    class Date < Input
      def initialize(
        value : Time,
        error : UI::ErrorI,
        label : String,
        name : String | Symbol,
      )
        @value = value
        @error = error
        @label = label
        @name = name
      end

      getter :value, :error, :label, :name

      ECR.def_to_s "./src/ui/inputs/date.ecr"
    end
  end
end
