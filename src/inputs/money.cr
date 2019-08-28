require "ecr"
require "../builders/errors"

module Inputs
  class Money
    def initialize(value : ::Money, error : Builders::Error | Builders::NonError)
      @value = value
      @error = error
    end

    getter :value, :error

    ECR.def_to_s "./src/inputs/money.ecr"
  end
end
