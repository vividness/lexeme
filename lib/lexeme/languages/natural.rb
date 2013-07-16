module Lexeme
  module Language
    def self.natural
      Proc.new do 
        token :STOP => /^\.$/
        token :COMA => /^,$/
        token :QUES => /^\?$/
        token :EXCL => /^!$/
        token :QUOT => /^"$/
        token :APOS => /^'$/
        token :WORD => /^[\w\-]+$/
      end
    end
  end
end
