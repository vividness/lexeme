module Lexeme
  class Token 
    attr_reader :name, :value, :line

    def initialize(name, value, line)
      @name  = name
      @value = value
      @line  = line
    end

    def to_s
      "#{line} => #{name} : #{value}"
    end

    def to_hash
      {:line => line, :name => name, :value => value}
    end

    def to_ary
      [name, value, line]
    end

    def to_array
      to_ary
    end

    def to_a
      to_ary
    end
  end
end
