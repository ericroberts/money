require "spec"
require "../../src/builders/transaction"

describe Builders::Transaction do
  describe "#to_domain" do
    describe "when all data is valid and of the right types" do
      it "should return a domain transaction" do
        date = Time.now
        amount = Money.new(10_000, "CAD")
        description = "Some kind of transaction"
        category = "A category"
        builder = Builders::Transaction.new(date, amount, description, category)
        builder.to_domain
      end
    end
  end
end
