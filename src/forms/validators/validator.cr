module Forms
  module Validators
    abstract class Validator
      abstract def validate(value) : Error | NonError
    end
  end
end
