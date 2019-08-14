require "../models/transaction"

module Builders
  class Transaction
    def initialize(
      date : Nil | String | Time,
      amount : Nil | String | Float64 | Int64 | Money,
      description : Nil | String,
      category : Nil | String,
    )
      @date = date
      @amount = amount
      @description = description
      @category = category
    end

    def to_domain
      Models::Transaction.new(
        id: "ohmygod",
        date: date,
        amount: Money.new(1000, "CAD"),
        description: "A description",
        category: "A category",
      )
    end

    def date
      local_date = @date
      case local_date
      when Time
        return local_date
      when Nil
        raise InvalidTransaction.new("Date cannot be nil")
      else
        Time.parse(
          local_date,
          "%Y-%m-%d",
          Time::Location::UTC,
        )
      end
    end

    def amount
    end

    def description
    end

    def category
    end
  end

  class InvalidTransaction < Exception
  end
end
