module Lexeme
  class Lexeme
    attr_accessor :ruleset
    attr_reader   :tokens
    
    def analyze(&block)
      instance_eval(&block)
    end

    def from_file(filepath = nil)
      raise ArgumentError, 'Argument 1 must be a String' unless
        filepath.instance_of? String

      raise ArgumentError, 'Source not defined' if 
        filepath.empty?
      
      raise RuntimeError, 'Source file not readable' unless 
        File.exists?(filepath)
      
      @tokens = scan(IO.read(filepath))
    end

    def from_string(source)
      raise ArgumentError, 'Argument 1 must be a String' unless
        source.instance_of? String

      raise ArgumentError, 'Source not defined' if 
        source.empty?
      
      @tokens = scan(source)
    end

    def token(params)
      @ruleset ||= Ruleset.new

      name  = params.keys.first   || nil
      regex = params.values.first || nil 
      @ruleset.rule(name, regex)
      
      @ruleset
    end
    
    def use_language(name)
      lang_file = "lexeme/languages/#{name}.rb"
      require lang_file

      instance_eval(&Language::send(name))
    rescue LoadError
      abort "Language file #{lang_file} cannot be found"
    end

    private 
    
    # TODO: Work on the time complexity for this one
    #       This could be better.
    def scan(input)
      previous = ''
      current  = ''
      tokens   = []
      new_line = 0
      line_num = 1

      input.each_char do |c|
        if c == "\n"
          new_line += 1
          line_num += 1
          c = ' '
        else 
          new_line = 0
        end
        
        if !previous.empty? && ignorable?(previous)
          previous = ''
          current  = ''
        end
  
        current << c
        
        if !identifiable?(current)
          raise RuntimeError, "Unknown token `#{current}` on line #{line_num - new_line}" if 
            previous.empty?
          
          token = identify(previous, line_num - new_line)
          
          raise RuntimeError, "Unknown token `#{previous}` on line #{line_num - new_line}" if 
            token.nil? || token.name.nil?

          tokens  << token
          previous = c.clone
          current  = c.clone
          next
        end
        
        previous = current.clone
      end
      
      if !previous.empty? && !ignorable?(previous)
        token = identify(previous, line_num - new_line) 
        raise RuntimeError, "Unknow token `#{previous}` on line #{line_num - new_line}" if
          token.nil? || token.name.nil?
        
        tokens << token
      end

      tokens
    end
    
    def ignorable?(string)
      @ruleset.ignorable?(string)
    end
    
    def identifiable?(string)
      @ruleset.identifiable?(string)
    end

    def identify(string, line)
      @ruleset.identify(string, line)
    end
  end
end
