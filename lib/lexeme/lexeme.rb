module Lexeme
  class Lexeme
    attr_accessor :ruleset

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

    private 

    def scan(input)
      previous = ''
      current  = ''
      tokens   = []
      line     = 1

      input.each_char do |c|
        line += 1 if c == "\n"

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
