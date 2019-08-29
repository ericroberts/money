module Builders
  class Errors
    def initialize
      @errors = {} of Symbol => Error
    end

    private getter :errors

    def add(property, error_code)
      errors[property] = Error.new(error_code)
    end

    def for(property)
      errors.fetch(property, NonError.new)
    end

    def exists?(property)
      for(property).error?
    end

    def none?
      errors.none? { |_property, e| e.error? }
    end
  end

  class Error
    def initialize(code : Symbol)
      @code = code
    end

    getter :code

    def error?
      true
    end

    def ==(other)
      other.is_a?(Error) && other.code == code
    end
  end

  class NonError
    def error?
      false
    end
  end
end
