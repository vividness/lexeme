require 'lexeme/rule'
require 'lexeme/ruleset'
require 'lexeme/token'
require 'lexeme/lexeme'
require 'lexeme/core_extensions'
require 'lexeme/version'

module Lexeme
  def self.define(&block)
    @lexer = Lexeme.new 
    @lexer.instance_eval(&block)
    
    @lexer
  end

  def self.reset!
    remove_instance_variable(:@lexer) if @lexer
  end
end
