require "./expense"

module Models
  class ExpenseList
    include Enumerable(Models::Expense)

    protected getter :expenses

    def initialize(expenses : Array(Models::Expense))
      @expenses = expenses
    end

    def to_json
      expenses.to_json
    end

    def each
      expenses.each { |expense| yield expense }
    end

    def +(other)
      self.class.new(expenses + other)
    end

    def total_spent
      expenses.reduce(Money.new(0, "CAD")) do |sum, expense|
        sum + expense.amount
      end
    end

    def total_gained
      Money.new(0, "CAD")
    end

    def order(attr)
      case attr
      when :date
        self.class.new(expenses.sort_by { |e| e.date })
      else
        raise ArgumentError.new("Unsupported order attribute: #{attr}")
      end
    end
  end
end
