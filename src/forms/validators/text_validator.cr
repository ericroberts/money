module Forms
  module Validators
    abstract class TextValidator
      abstract def validate(value : Time) : Error | NonError
    end
  end
end
