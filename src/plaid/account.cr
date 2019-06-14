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
  end
end
