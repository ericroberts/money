require "../form"
require "./property"

module Forms
  module Properties
    class Money < ::Forms::Properties::Property
      def self.default(name)
        new(name, "0")
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
