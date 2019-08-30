require "../../ui/inputs/text"
require "../form"
require "./property"

module Forms
  module Properties
    class Text < ::Forms::Properties::Property
      def self.default(name)
        new(name, "")
      end

      def convertable_to_ui?
        true
      end

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
    end
  end
end
