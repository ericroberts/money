module UI
  module Inputs
    class Input
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

      def render
        to_s
      end
    end
  end
end
