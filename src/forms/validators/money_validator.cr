module Forms
  module Validators
    abstract class MoneyValidator
      abstract def validate(value : Money) : Error | NonError
    end
  end
end
