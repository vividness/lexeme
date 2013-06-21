module Lexeme
  class Token 
    attr_reader :name, :value

    def initialize(name, value)
      @name  = name
      @value = value
    end

    def to_text
      "#{@name}: #{@value}"
    end

    def to_array
      [@name, @value]
    end
  end
end
