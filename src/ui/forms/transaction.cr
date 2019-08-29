require "ecr"

require "../inputs/date"
require "../inputs/money"
require "../inputs/text"
require "../inputs/radios"
require "../inputs/radio"
require "../error"
require "./form"
require "../../forms/properties/date"

module UI
  module Forms
    class NewTransaction
      def self.build(form)
        date_property = form.properties.find { |name, property| name == :date }
        raise "FUCK" if date_property.nil?
        Form.new(
          inputs: [
            date_property[1].as(::Forms::Properties::Date).to_ui_input(
              :date,
              Strings[:fields][:date][:label],
              Strings[:fields][:date][:errors],
            )
          ] + [
            {:amount, UI::Inputs::Money},
            {:description, UI::Inputs::Text},
            {:category, UI::Inputs::Text},
          ].map do |property_name, input_type|
            input_type.new(
              form.value(property_name),
              UI::Error.build(
                form.error(property_name),
                Strings[:fields][property_name][:errors],
              ),
              Strings[:fields][property_name][:label],
              property_name,
            )
          end
        )
      end
    end

    class Transaction
      def self.build(builder)
        Form.new(
          inputs: [
            UI::Inputs::Date.new(
              value: builder.value(:date).to_s("%Y-%m-%d"),
              error: UI::Error.build(
                builder.errors.for(:date),
                Strings[:fields][:date][:errors]
              ),
              label: Strings[:fields][:date][:label],
              name: :date,
            ),
            UI::Inputs::Money.new(
              value: builder.amount.format(currency_code: ""),
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
              error: UI::Error.build(
                builder.errors.for(:type),
                Strings[:fields][:type][:errors],
              ),
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
          errors: {} of Symbol => String,
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
