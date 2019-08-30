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
    def self.build(date, amount, description, category, type)
      new(
        properties: {
          date: Properties::Date.new(:date, date),
          amount: Properties::Money.new(:amount, amount),
          description: Properties::Text.new(:description, description),
          category: Properties::Text.new(:category, category),
          type: Properties::OptionsList.new(:type, type, ["in", "out"])
        }
      )
    end

    def self.empty
      Form.new(
        properties: {
          :date => Properties::Date.default(:date),
          :amount => Properties::Money.default(:amount),
          :description => Properties::Text.default(:description),
          :category => Properties::Text.default(:category),
          :type => Properties::OptionsList.new(:type, "in", ["in", "out"])
        },
      )
    end
  end
end
