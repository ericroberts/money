require  "./errors"
require "../models/transaction"

module Builders
  class Transaction
    def initialize(
      date : String | Time,
      amount : String | ::Money,
      description : String,
      category : String,
      type : String,
      errors : Errors = Errors.new,
    )
      @date = date
      @amount = amount
      @description = description
      @category = category
      @type = type
      @errors = errors
    end

    getter :errors, :description, :category, :type

    def self.empty
      new(date: Time.now, amount: "", description: "", category: "", type: "in")
    end

    def validate
      validate_date
      validate_amount
      validate_description
      validate_category
    end

    def valid?
      validate
      errors.none?
    end

    def validate_date
      local_date = @date
      case local_date
      when Time
        return local_date
      else
        begin
          Time.parse(
            local_date,
            "%Y-%m-%d",
            Time::Location::UTC,
          )
        rescue Time::Format::Error
          errors.add(:date, :invalid_format)
        end
      end
    end

    def validate_amount
      local_amount = @amount
      case local_amount
      when String
        errors.add(:amount, :invalid) if local_amount.strip == ""
      end
    end

    def validate_description
      errors.add(:description, :invalid) if @description.strip == ""
    end

    def validate_category
      errors.add(:category, :invalid) if @category.strip == ""
    end

    def date
      local_date = @date
      case local_date
      when Time
        local_date
      else
        Time.parse(
          local_date,
          "%Y-%m-%d",
          Time::Location::UTC,
        )
      end
    end

    def amount
      local_amount = @amount
      case local_amount
      when ::Money
        return local_amount
      else
        if local_amount.strip == ""
          ::Money.new(0, "CAD")
        else
          ::Money.new(local_amount.to_f * 100, "CAD")
        end
      end
    end
  end

  class InvalidTransaction < Exception
  end
end
