module Lexeme
  class Ruleset
    def initialize(&block)
      @rules  = []
      @ignore = [] 
      
      # this is here to capture any other
      # symbols that could be identified
      # as var names, function names ...
      @unknown = Rule.new(nil, /^\w+$/)

      # this skips all whitespaces by default
      @ignore << /^\s+/

      yield self if block_given?
    end

    def rule(name, regex)
      @rules << Rule.new(name, regex)
    end

    def ignore(regex)
      @ignore << regex
    end

    def ignorable?(string)
      @ignore.each do |i|
        return true if string =~ i
      end

      false
    end

    def identifiable?(string)
      @rules.each do |r|
        return true if string =~ r.regex
      end

      return true if string =~ @unknown.regex
      
      @ignore.each do |i|
        return true if string =~ i
      end

      false
    end

    def identify(string, line)
      @rules.each do |r|
        return Token.new(r.name, string, line) if string =~ r.regex
      end
      
      return Token.new(@unknown.name, string, line) if 
        string =~ @unknown.regex

      nil
    end
  end 
end
