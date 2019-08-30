require "money"

require "../../ui/inputs/money"
require "../errors"
require "./property"

module Forms
  module Properties
    class Money < Property
      def self.default(name)
        new(name, "0")
      end

      def to_ui_input(label, error_messages, input_type = UI::Inputs::Money)
        super(label, error_messages, input_type)
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
