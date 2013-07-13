module Lexeme
  class Lexeme
    attr_accessor :ruleset

    def from_file(filepath = nil)
      raise ArgumentError, 'Argument 1 must be a String' unless
        filepath.instance_of? String

      raise ArgumentError, 'Source not defined' if 
        filepath.empty?
      
      raise RuntimeError, 'Source file not readable' unless 
        File.exists?(filepath)
      
            
      scan IO.read(filepath)
    end

    def from_string(source)
      raise ArgumentError, 'Argument 1 must be a String' unless
        source.instance_of? String

      raise ArgumentError, 'Source not defined' if 
        source.empty?
      
      scan source
    end

    # Used by the Lexeme.define method
    def token(params)
      @ruleset ||= Ruleset.new

      name  = params.keys.first   || nil
      regex = params.values.first || nil 
      @ruleset.rule(name, regex)
      
      @ruleset
    end

    private 
    
    # TODO: Work on the time complexity for this one
    #       This could be better.
    def scan(input)
      previous = ''
      current  = ''
      tokens   = []
      line     = 1

      input.each_char do |c|
        if c == "\n"
          line += 1
          c = ' '
        end
        
        if !previous.empty? && ignorable?(previous)
          previous = ''
          current  = ''
        end
  
        current << c
        
        if !identifiable?(current)
          raise RuntimeError, "Unknown token `#{current}` on line #{line}" if 
            previous.empty?
          
          token = identify(previous)
          
          raise RuntimeError, "Unknown token `#{previous}` on line #{line}" if 
            token.nil? || token.name.nil?

          tokens  << token
          previous = c.clone
          current  = c.clone
          next
        end
        
        previous = current.clone
      end
      
      if !previous.empty? && !ignorable?(previous)
        token = identify(previous)
        raise RuntimeError, "Unknow token `#{previous}` on line #{line}" if
          token.nil? || token.name.nil?
        
        tokens << token
      end

      tokens
    end
    
    def ignorable?(string)
      @ruleset.ignorable?(string)
    end
    
    def identifiable?(string)
      @ruleset.identifiable? string
    end

    def identify(string)
      @ruleset.identify string
    end
  end
end
