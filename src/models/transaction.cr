require "json"
require "money"

module Models
  class Transaction
    include JSON::Serializable

    property id : String
    property date : Time
    property amount : Money
    property description : String
    property category : String
    property type : String

    getter :amount, :description, :category, :type

    def initialize(
      id : String,
      date : Time,
      amount : Money,
      description : String,
      category : String,
      type : String,
    )
      @id = id
      @date = date
      @amount = amount
      @description = description
      @category = category
      @type = type
    end
  end
end
