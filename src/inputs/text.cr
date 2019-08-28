require "ecr"
require "../builders/errors"

module Inputs
  class Text
    def initialize(value : String, error : Builders::Error | Builders::NonError, label : String, name : String)
      @value = value
      @error = error
      @label = label
      @name = name
    end

    getter :value, :error, :label, :name

    ECR.def_to_s "./src/inputs/text.ecr"
  end
end
