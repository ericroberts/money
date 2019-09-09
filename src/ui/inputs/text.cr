require "ecr"
require "../error"
require "./input"

module UI
  module Inputs
    class Text < Input
      ECR.def_to_s "./src/ui/inputs/text.ecr"
    end
  end
end
