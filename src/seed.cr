require "faker"
require "./repositories/expense"

class Seed
  def self.run
    year = Time.now.year
    month = Time.now.month
    day = Time.now.day

    Repositories::Expense.delete_all
    (0..25).each { |n|
      Repositories::Expense.create(
        date: Time.new(year, month, Random.new.rand(1..27)),
        amount: Money.new(Random.new.rand(212..10_000), "CAD"),
        description: Faker::Lorem.sentence,
        category: Faker::Commerce.department,
      )
    }
  end
end

Seed.run
