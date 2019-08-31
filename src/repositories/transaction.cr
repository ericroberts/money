require "../models/transaction"
require "../models/transaction_list"

module Repositories
  class Transaction
    FILE_PATH = "./data/transactions.json"

    def self.all
      File.open(FILE_PATH) do |file|
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
      File.write(FILE_PATH, "[]")
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
        FILE_PATH,
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

    def self.create_from_model(model)
      File.write(FILE_PATH, (all + [model]).to_json)
    end

    def self.delete_all
      File.write(FILE_PATH, "[]")
    end

    def self.delete(id : String)
      File.write(
        FILE_PATH,
        all.reject { |expense| expense.id == id }.to_json
      )
    end

    def self.generate_id
      Random::Secure.hex(8)
    end
  end
end
