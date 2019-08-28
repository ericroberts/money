module UI
  abstract class ErrorI
    abstract def class_name
    abstract def render
    abstract def error?
  end

  class Error < ErrorI
    def self.build(error, messages)
      case error
      when Builders::NonError
        NonError.new
      else
        Error.new(messages[error.code])
      end
    end

    def initialize(message : String)
      @message = message
    end

    getter :message

    def error?
      true
    end

    def class_name
      "error"
    end

    def render
      ECR.render("#{__DIR__}/error.ecr")
    end
  end

  class NonError < ErrorI
    def error?
      false
    end

    def class_name
    end

    def render
    end
  end
end
