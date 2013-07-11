class ::String 
  def to_tokens
    content = to_s

    Lexeme.define do
      token :STOP => /^\.$/
      token :COMA => /^,$/
      token :QUES => /^\?$/
      token :EXCL => /^!$/
      token :QUOT => /^"$/
      token :APOS => /^'$/
      token :WORD => /^[\w\-]+$/
    end
    
    Lexeme.analyze do
      return from_string content
    end
  end
end
