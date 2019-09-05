module Forms
  module Validators
    abstract class TimeValidator
      abstract def validate(value : Time) : Error | NonError
    end
  end
end
