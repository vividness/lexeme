module Lexeme
  class Rule
    attr_reader :name, :regex

    def initialize(name, regex)
      raise ArgumentError, 'name must be a String or a Symbol' unless 
        name.nil? || name.is_a?(String) || name.is_a?(Symbol)
      raise ArgumentError, 'regex must be a Regex' unless 
        regex.is_a? Regexp
      
      @name  = name
      @regex = regex
    end
  end
end
