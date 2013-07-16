class ::String 
  def to_tokens
    @lexer ||= Lexeme.define do
      token :STOP => /^\.$/
      token :COMA => /^,$/
      token :QUES => /^\?$/
      token :EXCL => /^!$/
      token :QUOT => /^"$/
      token :APOS => /^'$/
      token :WORD => /^[\w\-]+$/
    end
    
    string_content = self 

    @lexer.analyze do
      from_string string_content
    end

    @lexer.tokens
  end
end
