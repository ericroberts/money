require "../errors"
require "../validators/validator"
require "./property"

module Forms
  module Properties
    class OptionsList < Property
      def initialize(
        name : Symbol,
        value : String,
        options : Array(String),
        validators : Array(
          ::Forms::Validators::Validator
        ) = [] of ::Forms::Validators::Validator,
      )
        @name = name
        @value = value
        @validators = validators
        @options = options
      end

      getter :value, :options

      def validate
        if options.includes?(value)
          NonError.new
        else
          Error.new(:invalid)
        end
      end
    end
  end
end
