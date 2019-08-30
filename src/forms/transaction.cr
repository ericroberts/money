require "./form"
require "./properties/date"
require "./properties/money"
require "./properties/text"
require "./properties/options_list"

module Forms
  alias TransactionProperties = NamedTuple(
    date: Properties::Date,
    amount: Properties::Money,
    description: Properties::Text,
    category: Properties::Text,
    type: Properties::OptionsList,
  )

  class Transaction < Form(TransactionProperties)
    IN = "in"
    OUT = "out"

    def self.build(date, amount, description, category, type)
      new(
        properties: {
          date: Properties::Date.new(:date, date),
          amount: Properties::Money.new(:amount, amount),
          description: Properties::Text.new(:description, description),
          category: Properties::Text.new(:category, category),
          type: Properties::OptionsList.new(:type, type, [IN, OUT])
        }
      )
    end

    def self.empty
      build(
        date: Properties::Date.default_value,
        amount: Properties::Money.default_value,
        description: Properties::Text.default_value,
        category: Properties::Text.default_value,
        type: IN,
      )
    end
  end
end
