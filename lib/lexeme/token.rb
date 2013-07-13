module Lexeme
  class Token 
    attr_reader :name, :value

    def initialize(name, value)
      @name  = name
      @value = value
    end

    def to_s
      "#{@name}: #{@value}"
    end

    def to_ary
      [@name, @value]
    end

    def to_array
      to_ary
    end
  end
end
