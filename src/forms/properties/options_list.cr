require "../errors"
require "../validators/validator"
require "./property"
require "../validators/text_validator"
require "../../ui/inputs/radios"

module Forms
  module Properties
    class OptionsList < Property(String, Validators::TextValidator)
      def initialize(
        name : Symbol,
        value : String,
        options : Array(Symbol),
        validators : Array(Validators::TextValidator) = [] of Validators::TextValidator
      )
        @name = name
        @value = value
        @validators = validators
        @options = options
        @error = NonError.new
      end

      getter :value, :options

      def to_ui_input(strings)
        UI::Inputs::Radios(typeof(strings)).new(
          value,
          UI::Error.build(@error, strings[:errors]),
          strings[:label],
          name,
          strings,
          options,
        )
      end
    end
  end
end
