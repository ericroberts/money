require "spec"
require "../../src/builders/transaction"

describe Builders::Transaction do
  describe "#validate" do
    # Valid values
    date = "1988-05-07"
    amount = "2000"
    description = "Some kind of transaction"
    category = "A category"
    type = "in"

    describe "date" do
      describe "when date is an empty string" do
        date = ""

        it "should add error code :blank for property :date" do
          builder = Builders::Transaction.new(date, amount, description, category, type)
          builder.validate
          builder.errors.for(:date).should eq(Builders::Error.new(:invalid))
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
