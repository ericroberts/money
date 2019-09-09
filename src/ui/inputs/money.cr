require "ecr"
require "../error"
require "./input"

module UI
  module Inputs
    class Money(S) < Input(S)
      ECR.def_to_s "./src/ui/inputs/money.ecr"
    end
  end
end
