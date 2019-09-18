require "../models/transaction"
require "../strings/forms/transaction"
require "../ui/forms/form"
require "./form"
require "./properties/date"
require "./properties/money"
require "./properties/options_list"
require "./properties/text"
require "./validators/string_presence"
require "./validators/inclusion"

module Forms
  alias TransactionProperties = NamedTuple(
    date: Properties::Date,
    amount: Properties::Money,
    description: Properties::Text,
    category: Properties::Text,
    type: Properties::OptionsList,
  )

  class Transaction < Form(TransactionProperties)
    IN = :in
    OUT = :out
    TYPE_OPTIONS = [IN, OUT]

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
          type: Properties::OptionsList.new(
            :type,
            type,
            options: TYPE_OPTIONS,
            validators: [
              Validators::Inclusion.new(
                TYPE_OPTIONS.map { |o| o.to_s }
              ).as(Validators::TextValidator)
            ],
          )
        }
      )
    end

    def self.empty
      build(
        date: Properties::Date.default_value,
        amount: Properties::Money.default_value,
        description: Properties::Text.default_value,
        category: Properties::Text.default_value,
        type: IN.to_s,
      )
    end

    def to_model
      Models::Transaction.new(
        id: Random::Secure.hex(8),
        date: properties[:date].coerced_value,
        amount: properties[:amount].coerced_value,
        description: properties[:description].coerced_value,
        category: properties[:category].coerced_value,
        type: properties[:type].coerced_value,
      )
    end

    def to_ui_form
      field_strings = Strings::Forms::Transaction[:fields]
      UI::Forms::Form.new(
        inputs: [
          properties[:date].to_ui_input(field_strings[:date]),
          properties[:amount].to_ui_input(field_strings[:amount]),
          properties[:description].to_ui_input(field_strings[:description]),
          properties[:category].to_ui_input(field_strings[:category]),
          properties[:type].to_ui_input(field_strings[:type]),
        ]
      )
    end
  end
end
