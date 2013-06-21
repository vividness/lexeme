module Lexeme
  class Ruleset
    def initialize(&block)
      @rules  = []
      @ignore = []
      
      @unknown = Rule.new(nil, /^\w+$/)
      @ignore << /\s+/

      yield self if block_given?
    end

    def rule(name, regex)
      @rules << Rule.new(name, regex)
    end

    def ignore(regex)
      @ignore << regex
    end

    def ignorable?(char)
      @ignore.each do |i|
        return true if char =~ i
      end

      false
    end

    def identifiable?(string)
      @rules.each do |r|
        return true if string =~ r.regex
      end

      return true if string =~ @unknown.regex

      false
    end

    def identify(string)
      @rules.each do |r|
        return Token.new(r.name, string) if string =~ r.regex
      end
      
      return Token.new(@unknown.name, string) if 
        string =~ @unknown.regex

      nil
    end
  end 
end
