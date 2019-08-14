require "../models/transaction"
require "../models/transaction_list"

module Repositories
  class Transaction
    def self.all
      File.open("data/expenses.json") do |file|
        Models::TransactionList.new(
          JSON.parse(file).as_a.map do |expense_json|
            Models::Transaction.new(
              id: expense_json["id"].as_s,
              date: Time.from_json(expense_json["date"].to_json),
              amount: Money.from_json(expense_json["amount"].to_json),
              description: expense_json["description"].as_s,
              category: expense_json["category"].as_s,
            )
          end
        )
      end
    rescue Errno
      File.write("data/expenses.json", "[]")
      Models::TransactionList.new([] of Models::Transaction)
    end

    def self.this_month
      Models::TransactionList.new(
        all.select { |expense| expense.date.month == Time.now.month }
      )
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
            Models::Transaction.new(
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

    def self.delete_all
      File.write("data/expenses.json", "[]")
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
