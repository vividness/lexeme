module Lexeme
  class Token 
    attr_accessor :name, :value

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

    def to_hash
      {:name => @name, :value => @value}
    end

    def to_json
      "{'name' : #{@name}, 'value' : #{@value}}"
    end
  end
end
