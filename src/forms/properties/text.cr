require "../../ui/inputs/text"
require "../errors"
require "./property"

module Forms
  module Properties
    class Text < Property
      def self.default(name)
        new(name, "")
      end

      def to_ui_input(label, error_messages, input_type = UI::Inputs::Text)
        super(label, error_messages, input_type)
      end

      def validate
        NonError.new
      end
    end
  end
end
