require "json"
require "money"

module Plaid
  class Transaction
    include JSON::Serializable

    getter :id, :date, :name, :amount, :categories

    property id : String
    property date : Time
    property name : String
    property amount : Money
    property categories : Array(String)

    def initialize(
      id : String,
      date : Time,
      name : String,
      amount : Money,
      categories : Array(String),
    )
      @id = id
      @date = date
      @name = name
      @amount = amount
      @categories = categories
    end
  end
end
