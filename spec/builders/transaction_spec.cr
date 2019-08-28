require "spec"
require "../../src/builders/transaction"

describe Builders::Transaction do
  describe "#validate" do
    # Valid values
    date = Time.now
    amount = Money.new(10_000, "CAD")
    description = "Some kind of transaction"
    category = "A category"

    describe "date" do
      describe "when date is an empty string" do
        date = ""

        it "should add error code :blank for property :date" do
          builder = Builders::Transaction.new(date, amount, description, category)
          builder.validate
          builder.errors.for(:date).should contain(:invalid_format)
        end
      end

      describe "when date is nil" do
      end

      describe "when date is a non parseable string" do
      end

      describe "when date is a time object" do
      end

      describe "when date is a parseable string" do
      end
    end
  end
end
