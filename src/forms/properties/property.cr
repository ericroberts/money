require "../errors"
require "../../ui/error"
require "../../ui/inputs/text"
require "../../forms/validators/validator"

module Forms
  module Properties
    class CoercionError < Exception
    end

    class Property(CoercedValueType, ValidatorType)
      @error : Error | NonError

      def initialize(
        name : Symbol,
        value : String,
        validators : Array(ValidatorType) = [] of ValidatorType
      )
        @name = name
        @value = value
        @validators = validators
        @error = NonError.new
      end

      getter :name, :value
      private getter :validators

      def input_type
        UI::Inputs::Text
      end

      def to_ui_input(strings)
        input_type.new(
          value,
          UI::Error.build(@error, strings[:errors]),
          strings[:label],
          name,
        )
      end

      def validate
        coerced_value
        errors = validators.map do |validator|
          validator.validate(coerced_value).as(Error | NonError)
        end
        @error = errors.find { |e| e.is_a?(Error) } || NonError.new
      rescue CoercionError
        @error = Error.new(:invalid)
      end

      def coerced_value : CoercedValueType
        value
      end
    end
  end
end
