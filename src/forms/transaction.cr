require "../models/transaction"
require "../strings/forms/transaction"
require "../ui/forms/form"
require "./form"
require "./properties/date"
require "./properties/money"
require "./properties/options_list"
require "./properties/text"
require "./validators/string_presence"

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
          description: Properties::Text.new(
            :description,
            description,
            validators: [Validators::StringPresence.new.as(Validators::TextValidator)],
          ),
          category: Properties::Text.new(
            :category,
            category,
            validators: [Validators::StringPresence.new.as(Validators::TextValidator)],
          ),
          type: Properties::OptionsList.new(:type, type, options: [IN, OUT])
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

    def to_model
      Models::Transaction.new(
        id: Random::Secure.hex(8),
        date: properties[:date].coerced_value,
        amount: properties[:amount].coerced_value,
        description: properties[:description].coerced_value,
        category: properties[:category].coerced_value,
      )
    end

    def to_ui_form
      UI::Forms::Form.new(
        inputs: properties.values.map do |property|
          property.to_ui_input(
            Strings::Forms::Transaction[:fields][property.name]
          ).as(UI::Inputs::Input)
        end.to_a
      )
    end
  end
end
