require "../form"
require "./property"

module Forms
  module Properties
    class Text < ::Forms::Properties::Property
      def initialize(value : String)
        @value = value
      end

      getter :value

      def self.default
        new("")
      end

      def validate
        NonError.new
      end
    end
  end
end
