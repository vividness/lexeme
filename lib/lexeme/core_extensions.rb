class ::String
  # Will move to tokenize and have #to_tokens obsolete
  def to_tokens
    @lexer ||= Lexeme.define do 
      use_language :natural
    end
    
    string_content = self 

    @lexer.analyze do
      from_string string_content
    end

    @lexer.tokens
  end

  def tokenize
    to_tokens
  end
end
