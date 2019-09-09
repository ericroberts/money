require "ecr"

require "../inputs/input"

module UI
  module Forms
    class Form
      def initialize(inputs : Array(UI::Inputs::InputI))
        @inputs = inputs
      end

      getter :inputs

      def render
        ECR.render("#{__DIR__}/form.ecr")
      end
    end
  end
end
