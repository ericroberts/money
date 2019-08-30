require "../form"
require "./property"

module Forms
  module Properties
    class OptionsList < ::Forms::Properties::Property
      def initialize(name : Symbol, value : String, options : Array(String))
        @name = name
        @value = value
        @options = options
      end

      getter :value, :options

      def validate
        if options.includes?(value)
          NonError.new
        else
          Error.new(:invalid)
        end
      end
    end
  end
end
