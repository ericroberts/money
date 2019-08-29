require "./form"
require "./properties/date"
require "./properties/money"
require "./properties/text"
require "./properties/options_list"

module Forms
  class Transaction
    def self.empty
      Form.new(
        properties: {
          :date => Properties::Date.default,
          :amount => Properties::Money.default,
          :description => Properties::Text.default,
          :category => Properties::Text.default,
          :type => Properties::OptionsList.new("in", ["in", "out"])
        },
      )
    end
  end
end
