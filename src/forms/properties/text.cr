require "../../ui/inputs/text"
require "../errors"
require "./property"

module Forms
  module Properties
    class Text < Property
      def self.default_value
        ""
      end

      def to_ui_input(label, error_messages, input_type = UI::Inputs::Text)
        super(label, error_messages, input_type)
      end
    end
  end
end
