require "../../ui/inputs/text"
require "../errors"
require "./property"
require "../validators/text_validator"

module Forms
  module Properties
    class Text < Property(String, Validators::TextValidator)
      def self.default_value
        ""
      end

      def to_ui_input(label, error_messages, input_type = UI::Inputs::Text)
        super(label, error_messages, input_type)
      end
    end
  end
end
