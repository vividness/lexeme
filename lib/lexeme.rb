require 'lexeme/rule'
require 'lexeme/ruleset'
require 'lexeme/token'
require 'lexeme/lexeme'
require 'lexeme/core_extensions'
require 'lexeme/version'

module Lexeme
  def self.analyze(source = nil)
    raise RuntimeError, 'Please use #define before calling #analyze.' unless @lexer
    
    return @lexer.instance_eval(&Proc.new) if 
      block_given?
    
    return @lexer.analyze(source) unless 
      source.nil?

    raise ArgumentError, 'Invalid parameters. Expected string or block.'
  end
  
  def self.define(&block)
    @lexer = Lexeme.new 
    @lexer.instance_eval(&block)
    
    @lexer
  end

  def self.reset!
    remove_instance_variable(:@lexer) if @lexer
  end
end
