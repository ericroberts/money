require "spec"
require "../../src/inputs/date"
require "../../src/builders/errors"

describe Inputs::Date do
  describe "#to_s" do
    it "should do as expected" do
      Inputs::Date.new(Time.now, Builders::Errors.new).to_s.should eq("")
    end
  end
end
