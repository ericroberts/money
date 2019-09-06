require "money"

require "../../ui/inputs/money"
require "../errors"
require "./property"
require "../validators/money_validator"

module Forms
  module Properties
    class Money < Property(::Money, Validators::MoneyValidator)
      def self.default_value
        "0"
      end

      def input_type
        UI::Inputs::Money
      end

      def coerced_value
        ::Money.new(value.to_f, "CAD")
      rescue
        raise CoercionError.new("#{value} cannot be coerced to Money")
      end
    end
  end
end
