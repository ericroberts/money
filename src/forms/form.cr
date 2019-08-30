require "./properties/property"
require "./errors"

module Forms
  class Form(T)
    def initialize(
      properties : T,
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
end
