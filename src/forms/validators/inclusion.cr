require "../errors"
require "./text_validator"

module Forms
  module Validators
    class Inclusion < TextValidator
      def initialize(set : Array(String))
        @set = set
      end

      private getter :set

      def validate(value)
        if set.includes?(value)
          NonError.new
        else
          Error.new(:invalid)
        end
      end
    end
  end
end
