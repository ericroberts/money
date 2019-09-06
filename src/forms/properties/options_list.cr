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
        options : Array(String),
        validators : Array(Validators::TextValidator) = [] of Validators::TextValidator
      )
        @name = name
        @value = value
        @validators = validators
        @options = options
        @error = NonError.new
      end

      getter :value, :options

      def to_ui_input(
        strings,
        input_type = UI::Inputs::Radios,
      )
        input_type.new(
          value,
          UI::Error.build(@error, strings[:errors]),
          strings[:label],
          name,
          options.map do |option|
            { label: option, value: option }
          end
        )
      end

      def validate
        if options.includes?(value)
          super
        else
          Error.new(:invalid)
        end
      end
    end
  end
end
