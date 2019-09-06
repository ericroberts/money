require "../../ui/inputs/date"
require "../errors"
require "./property"
require "../validators/time_validator"

module Forms
  module Properties
    class Date < Property(Time, Validators::TimeValidator)
      def self.default_value
        Time.now.to_s("%Y-%m-%d")
      end

      def input_type
        UI::Inputs::Date
      end

      def coerced_value
        Time.parse(
          value,
          "%Y-%m-%d",
          Time::Location::UTC,
        )
      rescue Time::Format::Error
        raise CoercionError.new("#{value} cannot be coerced to Time")
      end
    end
  end
end
