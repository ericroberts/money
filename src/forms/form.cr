require "./properties/property"

module Forms
  class Form
    def initialize(
      properties : Hash(Symbol, Properties::Property),
      errors = Errors.new
    )
      @properties = properties
      @errors = errors
    end

    getter :properties, :errors

    def validate
      properties.each do |name, property|
        error = property.validate
        error.add_to(errors, property.name)
      end
    end

    def valid?
      validate
      errors.none?
    end
  end

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

    def none?
      errors.none? { |_, error| error.is_a?(Error) }
    end
  end

  class Error
    def initialize(code : Symbol)
      @code = code
    end

    getter :code

    def add_to(errors, property_name)
      errors.add(property_name, code)
    end

    def ==(other)
      other.is_a?(Error) && other.code == code
    end
  end

  class NonError
    def add_to(errors, property_name)
    end
  end
end
