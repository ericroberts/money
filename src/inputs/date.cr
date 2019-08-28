require "ecr"
require "../builders/errors"

module Inputs
  class Date
    def initialize(value : Time, error : Builders::Error | Builders::NonError)
      @value = value
      @error = error
    end

    getter :value, :error

    ECR.def_to_s "./src/inputs/date.ecr"
  end
end
