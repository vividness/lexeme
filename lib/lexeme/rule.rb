module Lexeme
  class Rule
    attr_reader :name, :regex

    def initialize(name, regex)
      raise ArgumentError, 'name must be a String' unless 
        name.is_a? String
      raise ArgumentError, 'regex must be a Regex' unless 
        regex.is_a? Regexp
      
      @name  = name
      @regex = regex
    end
  end
end
