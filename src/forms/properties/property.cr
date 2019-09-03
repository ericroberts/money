require "../errors"
require "../../ui/error"
require "../../ui/inputs/text"
require "../../forms/validators/validator"

module Forms
  module Properties
    class Property
      def initialize(
        name : Symbol,
        value : String,
        validators : Array(
          ::Forms::Validators::Validator
        ) = [] of ::Forms::Validators::Validator,
      )
        @name = name
        @value = value
        @validators = validators
      end

      getter :name, :value
      private getter :validators

      def to_ui_input(label, error_messages, input_type = UI::Inputs::Text)
        input_type.new(
          value,
          UI::Error.build(validate, error_messages),
          label,
          name,
        )
      end

      def validate
        errors = validators.map do |validator|
          validator.validate(value).as(Error | NonError)
        end
        errors.find { |e| e.is_a?(Error) } || NonError.new
      end

      def validated_value
        v = coerced_value
        raise "Invalid value" if v.is_a?(Error)
        v
      end

      def coerced_value
        value
      end
    end
  end
end
