require "ecr"

require "../inputs/date"
require "../inputs/money"
require "../inputs/text"
require "../inputs/radios"
require "../inputs/radio"
require "../error"
require "./form"

module UI
  module Forms
    class Transaction
      def self.build(builder)
        Form.new(
          inputs: [
            UI::Inputs::Date.new(
              value: builder.date,
              error: UI::Error.build(
                builder.errors.for(:date),
                Strings[:fields][:date][:errors]
              ),
              label: Strings[:fields][:date][:label],
              name: :date,
            ),
            UI::Inputs::Money.new(
              value: builder.amount,
              error: UI::Error.build(
                builder.errors.for(:amount),
                Strings[:fields][:amount][:errors]
              ),
              label: Strings[:fields][:amount][:label],
              name: :amount,
            ),
            UI::Inputs::Text.new(
              value: builder.description,
              error: UI::Error.build(
                builder.errors.for(:description),
                Strings[:fields][:description][:errors]
              ),
              label: Strings[:fields][:description][:label],
              name: :description,
            ),
            UI::Inputs::Text.new(
              value: builder.category,
              error: UI::Error.build(
                builder.errors.for(:category),
                Strings[:fields][:category][:errors]
              ),
              label: Strings[:fields][:category][:label],
              name: :category,
            ),
            UI::Inputs::Radios.new(
              value: builder.type,
              label: Strings[:fields][:type][:label],
              name: :type,
              options: [{
                label: Strings[:fields][:type][:fields][:in][:label],
                value: "in",
              }, {
                label: Strings[:fields][:type][:fields][:out][:label],
                value: "out",
              }],
            )
          ]
        )
      end

      Strings = {
        fields: {
          date: {
            label: "Date",
            errors: {
              invalid: "Please provide a date in the following format: YYYY-MM-DD",
            },
          },
          amount: {
            label: "Amount",
            errors: {
              invalid: "Please provide an amount (e.g. 9.99)",
            },
          },
          description: {
            label: "Description",
            errors: {
              invalid: "Please provide a description",
            },
          },
          category: {
            label: "Category",
            errors: {
              invalid: "Please provide a category",
            },
          },
          type: {
            label: "Type",
            fields: {
              in: {
                label: "In",
              },
              out: {
                label: "Out",
              },
            },
          },
        },
      }
    end
  end
end
