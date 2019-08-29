require "../form"
require "./property"

module Forms
  module Properties
    class Money < ::Forms::Properties::Property
      def initialize(value : String)
        @value = value
      end

      getter :value

      def self.default
        new("0")
      end

      def validate
        case coerced_value
        when Error
          coerced_value
        else
          NonError.new
        end
      end

      def coerced_value
        Money.new(value.to_f, "CAD")
      rescue
        Error.new(:invalid)
      end
    end
  end
end
