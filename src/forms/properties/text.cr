require "../form"
require "./property"

module Forms
  module Properties
    class Text < ::Forms::Properties::Property
      def self.default(name)
        new(name, "")
      end

      def validate
        NonError.new
      end
    end
  end
end
