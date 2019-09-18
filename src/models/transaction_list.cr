require "./transaction"

module Models
  class TransactionList
    include Enumerable(Models::Transaction)

    protected getter :expenses

    def initialize(expenses : Array(Models::Transaction))
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

    def total_out
      expenses.select { |e| e.type == "out" }.reduce(Money.new(0, "CAD")) do |sum, expense|
        sum + expense.amount
      end
    end

    def total_in
      expenses.select { |e| e.type == "in" }.reduce(Money.new(0, "CAD")) do |sum, expense|
        sum + expense.amount
      end
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
