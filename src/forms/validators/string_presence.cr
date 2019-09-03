require "../errors"
require "./validator"

module Forms
  module Validators
    class StringPresence < Validator
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
