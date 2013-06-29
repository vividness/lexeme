require 'lexeme/rule'
require 'lexeme/ruleset'
require 'lexeme/token'
require 'lexeme/lexeme'

module Lexeme
  VERSION = '0.0.1'

  # will become deprecated as of 0.0.2
  # instead of Lexeme.setup we will be calling
  # Lexeme.define
  def self.setup
    @lexer = Lexeme.new unless @lexer
    yield @lexer if block_given?
  end

  def self.analyze(source)
    tokens = @lexer.analyze(source)
    tokens.each { |t| yield t } if block_given?

    tokens
  end
  
  def self.define(&block)
    @lexer = Lexeme.new unless @lexer
    @lexer.instance_eval(&block)
    
    @lexer
  end
end
