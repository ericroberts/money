require "ecr"
require "../error"
require "./input"

module UI
  module Inputs
    class Text(S) < Input(S)
      ECR.def_to_s "./src/ui/inputs/text.ecr"
    end
  end
end
