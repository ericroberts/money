require "../errors"
require "./text_validator"

module Forms
  module Validators
    class StringPresence < TextValidator
      def validate(value)
        if value.strip == ""
          Error.new(:invalid)
        else
          NonError.new
        end
      end
    end
  end
end
