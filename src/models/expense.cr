require "json"
require "money"

module Models
  class Expense
    include JSON::Serializable

    property id : String
    property date : Time
    property amount : Money
    property description : String
    property category : String

    getter :amount, :description, :category

    def initialize(
      id : String,
      date : Time,
      amount : Money,
      description : String,
      category : String,
    )
      @id = id
      @date = date
      @amount = amount
      @description = description
      @category = category
    end
  end
end
