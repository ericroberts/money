require "ecr"

require "../inputs/date"
require "../inputs/money"
require "../inputs/text"

module Forms
  class Transaction
    def initialize(builder)
      @inputs = [
        Inputs::Date.new(builder.date, builder.errors.for(:date)),
        Inputs::Money.new(builder.amount, builder.errors.for(:amount)),
        Inputs::Text.new(
          value: builder.description,
          error: builder.errors.for(:description),
          label: "Description",
          name: "description",
        ),
        Inputs::Text.new(
          value: builder.category,
          error: builder.errors.for(:category),
          label: "Category",
          name: "category",
        ),
      ]
    end

    getter :inputs

    ECR.def_to_s "./src/forms/form.ecr"
  end
end
