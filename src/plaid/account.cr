require "json"
require "./transaction"

module Plaid
  class Account
    include JSON::Serializable

    getter :name, :transactions

    property name : String
    property transactions : Array(Transaction)

    def initialize(
      name : String,
      transactions : Array(Transaction)
    )
      @name = name
      @transactions = transactions
    end

    def self.from_json(account_data, transactions_data)
      raise "Account json must be provided" unless account_data
      new(
        name: account_data["name"].as_s,
        transactions: transactions_data.map do |t_json|
          Plaid::Transaction.from_json(t_json)
        end
      )
    end
  end
end
