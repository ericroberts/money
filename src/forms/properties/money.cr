require "../../ui/inputs/money"
require "../form"
require "./property"

module Forms
  module Properties
    class Money < ::Forms::Properties::Property
      def self.default(name)
        new(name, "0")
      end

      def convertable_to_ui?
        true
      end

      def to_ui_input(label, error_messages, input_type = UI::Inputs::Money)
        input_type.new(
          value,
          UI::Error.build(validate, error_messages),
          label,
          name,
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
        ::Money.new(value.to_f, "CAD")
      rescue
        Error.new(:invalid)
      end
    end
  end
end
