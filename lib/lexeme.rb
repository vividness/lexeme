require 'lexeme/rule'
require 'lexeme/ruleset'
require 'lexeme/token'
require 'lexeme/lexeme'
require 'lexeme/core_extensions'

module Lexeme
  VERSION = '0.0.1'

  # will become deprecated as of 0.0.2
  # instead of Lexeme.setup we will be calling
  # Lexeme.define
  def self.setup
    @lexer = Lexeme.new #unless @lexer
    yield @lexer if block_given?
  end

  def self.analyze(source = nil, &block)
    raise RuntimeError, 'Please use #define before calling #analyze.' unless @lexer
    
    return @lexer.instance_eval(&block) if 
      block_given?
    
    return @lexer.analyze(source) unless 
      source.nil?

    raise ArgumentError, 'Invalid parameters. Expected string or block.'
  end
  
  def self.define(&block)
    @lexer = Lexeme.new #unless @lexer
    @lexer.instance_eval(&block)
    
    @lexer
  end
end
