require "../form"
require "./property"

module Forms
  module Properties
    class Date < ::Forms::Properties::Property
      def initialize(value : String)
        @value = value
      end

      getter :value

      def self.default
        new(Time.now.to_s("%Y-%m-%d"))
      end

      def to_ui_input(property_name, label, error_messages, input_type = UI::Inputs::Date)
        input_type.new(
          value,
          UI::Error.build(validate, error_messages),
          label,
          property_name,
        )
      end

      def validate
        local_coerced_value = coerced_value
        case local_coerced_value
        when Error
          local_coerced_value
        else
          NonError.new
        end
      end

      def coerced_value
        Time.parse(
          value,
          "%Y-%m-%d",
          Time::Location::UTC,
        )
      rescue Time::Format::Error
        Error.new(:invalid)
      end
    end
  end
end
