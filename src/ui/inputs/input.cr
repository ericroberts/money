module UI
  module Inputs
    abstract class InputI
      abstract def render
    end

    class Input < InputI
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
