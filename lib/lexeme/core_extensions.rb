class ::String
  def tokenize 
    @lexer ||= Lexeme.define do 
      use_language :natural
    end
    
    string_content = self 

    @lexer.analyze do
      from_string string_content
    end

    @lexer.tokens
  end

  def to_tokens
    warn "String#to_tokens is obsolete, use String#tokenize instead"
    tokenize
  end
end
