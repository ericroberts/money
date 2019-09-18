require "faker"
require "./repositories/transaction"

class Seed
  def self.run
    year = Time.now.year
    month = Time.now.month
    day = Time.now.day

    Repositories::Transaction.delete_all
    (0..25).each { |n|
      Repositories::Transaction.create(
        date: Time.new(year, month, Random.new.rand(1..27)),
        amount: Money.new(Random.new.rand(212..10_000), "CAD"),
        description: Faker::Lorem.sentence,
        category: Faker::Commerce.department,
        type: ["in", "out"].sample,
      )
    }
  end
end

Seed.run
