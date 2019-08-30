require "./form"

module UI
  module Forms
    class Transaction
      def self.build(form)
        Form.new(
          inputs: form.properties.values.map do |property|
            property.to_ui_input(
              Strings[:fields][property.name][:label],
              Strings[:fields][property.name][:errors],
            )
          end.to_a
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
