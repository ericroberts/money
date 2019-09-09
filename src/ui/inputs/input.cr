module UI
  module Inputs
    abstract class InputI
      abstract def render
    end

    class Input(S) < InputI
      def initialize(
        value : String,
        error : UI::ErrorI,
        name : Symbol,
        strings : S,
      )
        @value = value
        @error = error
        @name = name
        @strings = strings
      end

      getter :value, :error, :name
      private getter :strings

      def label
        strings[:label]
      end

      def render
        to_s
      end
    end
  end
end
