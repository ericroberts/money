require "../errors"
require "../validators/validator"
require "./property"
require "../validators/text_validator"

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
