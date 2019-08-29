require "ecr"
require "../error"
require "./input"

module UI
  module Inputs
    class Date < Input
      ECR.def_to_s "./src/ui/inputs/date.ecr"
    end
  end
end
