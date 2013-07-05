module Lexeme
  class Lexeme
    attr_accessor :ruleset

    # NOTE: Deprecated as of 0.0.2 
    def analyze(source)
      raise ArgumentError, 'Argument 1 must be a String' unless
        source.instance_of? String

      raise ArgumentError, 'Source not defined' if 
        source.empty?
      
      raise RuntimeError, 'Source file not readable' unless 
        File.exists?(source)
      
      content = IO.read(source)
      tokens  = scan(content)
      
      tokens
    end
    
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

    def scan(input)
      previous = ''
      current  = ''
      tokens   = []
      line     = 1
      string_state = false

      input.each_char do |c|
        line += 1 if c == "\n"
        
        if c == "'" || c == '"'
          previous << c
          string_state ^= true
          next
        end

        if string_state
          previous << c
          next
        end

        if ignorable?(c)
          unless previous.empty?
            token   = identify(previous)
            raise RuntimeError, "Unknown token #{previous} on line #{line}!" if 
              token.nil? || token.name.nil?

            tokens << token 
          end

          previous = ''
          current  = ''
          next
        end

        current << c
        if !identifiable?(current)
          raise RuntimeError, "Unknown token #{current} on line #{line}!" if 
            previous.empty? 
          
          token = identify(previous)

          raise RuntimeError, "Unknown token #{previous} on line #{line}!" if 
            token.nil? || token.name.nil?

          tokens << token
          previous = c.clone
          current  = c.clone
          
          next
        end
        
        previous = current.clone
      end
      
      unless previous.empty?
        tokens << identify(previous)
      end

      tokens
    end
    
    def ignorable?(char)
      @ruleset.ignorable? char
    end
    
    def identifiable?(string)
      @ruleset.identifiable? string
    end

    def identify(string)
      @ruleset.identify string
    end
  end
end
