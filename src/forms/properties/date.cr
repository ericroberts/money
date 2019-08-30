require "../../ui/inputs/date"
require "../errors"
require "./property"

module Forms
  module Properties
    class Date < Property
      def self.default(name)
        new(name, Time.now.to_s("%Y-%m-%d"))
      end

      def to_ui_input(label, error_messages, input_type = UI::Inputs::Date)
        super(label, error_messages, UI::Inputs::Date)
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
