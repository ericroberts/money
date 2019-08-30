require "../errors"
require "../../ui/error"
require "../../ui/inputs/text"

module Forms
  module Properties
    class Property
      def initialize(name : Symbol, value : String)
        @name = name
        @value = value
      end

      getter :name, :value

      def to_ui_input(label, error_messages, input_type = UI::Inputs::Text)
        input_type.new(
          value,
          UI::Error.build(validate, error_messages),
          label,
          name,
        )
      end

      def validate
        NonError.new
      end

      def coerced_value
        value
      end
    end
  end
end
