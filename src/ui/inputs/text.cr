require "ecr"
require "../error"
require "./input"

module UI
  module Inputs
    class Text < Input
      def initialize(
        value : String,
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

      ECR.def_to_s "./src/ui/inputs/text.ecr"
    end
  end
end
