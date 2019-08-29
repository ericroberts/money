require "../form"
require "./property"

module Forms
  module Properties
    class OptionsList < ::Forms::Properties::Property
      def initialize(value : String, options : Array(String))
        @value = value
      end

      getter :value, :options

      def validate
        if options.contains?(value)
          NonError.new
        else
          Error.new(:invalid)
        end
      end
    end
  end
end
