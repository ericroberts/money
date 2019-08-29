require "ecr"
require "../error"
require "./input"

module UI
  module Inputs
    class Money < Input
      ECR.def_to_s "./src/ui/inputs/money.ecr"
    end
  end
end
