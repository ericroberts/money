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
    class Transaction
      def self.build(form)
        convertable, non_convertable = form.properties.values.partition do |property|
          property.convertable_to_ui?
        end

        converted = convertable.map do |property|
          property.to_ui_input(
            Strings[:fields][property.name][:label],
            Strings[:fields][property.name][:errors],
          )
        end

        Form.new(
          inputs: converted + [
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
