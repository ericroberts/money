module Strings
  module Forms
    Transaction = {
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
          errors: {
            invalid: "Please select a type",
          },
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
