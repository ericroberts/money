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

    def self.from_json(json)
      new(
        id: json["transaction_id"].as_s,
        date: Time.parse(
          json["date"].to_s,
          "%Y-%m-%d",
          Time::Location::UTC,
        ),
        amount: Money.new(json["amount"].to_s.to_f * 100, "CAD"),
        name: json["name"].as_s,
        categories: json["category"].as_a.map { |c| c.as_s },
      )
    end
  end
end
