require "../models/expense"

module Repositories
  class Expense
    def self.all
      File.open("data/expenses.json") do |file|
        JSON.parse(file).as_a.map do |expense_json|
          Models::Expense.new(
            id: expense_json["id"].as_s,
            date: Time.from_json(expense_json["date"].to_json),
            amount: Money.from_json(expense_json["amount"].to_json),
            description: expense_json["description"].as_s,
            category: expense_json["category"].as_s,
          )
        end
      end
    rescue Errno
      File.write("data/expenses.json", "[]")
      [] of Models::Expense
    end

    def self.create(
      date : Time,
      amount : Money,
      description : String,
      category : String,
    )
      File.write(
        "data/expenses.json",
        (
          all + [
            Models::Expense.new(
              id: generate_id,
              date: date,
              amount: amount,
              description: description,
              category: category,
            )
          ]
        ).to_json
      )
    end

    def self.delete(id : String)
      File.write(
        "data/expenses.json",
        all.reject { |expense| expense.id == id }.to_json
      )
    end

    def self.generate_id
      Random::Secure.hex(8)
    end
  end
end
