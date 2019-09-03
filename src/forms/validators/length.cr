require "../errors"
require "./validator"

module Forms
  module Validators
    class Length < Validator
      def initialize(length : Int64)
        @length = length
      end

      private getter :length

      def validate(value)
        if value.size < length
          Error.new(:invalid)
        else
          NonError.new
        end
      end
    end
  end
end
