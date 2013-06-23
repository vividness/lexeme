require 'spec_helper'

describe Lexeme do
  describe '#setup' do 
    it 'yields a new Lexeme object' do
      expect { |b| Lexeme.setup &b }.to yield_control
      expect { |b| Lexeme.setup &b }.to yield_with_args(Lexeme::Lexeme)
    end
  end

  describe '#analyze' do 
    it 'raise an error if source file is not defined' do
      Lexeme.setup
      
      expect { subject.analyze }.to raise_error(ArgumentError)
    end

    it 'raise an erorr if source file cannot be found' do
      Lexeme.setup
      expect { Lexeme.analyze '/root/surce.math' }.to raise_error(RuntimeError)
    end
    
    it 'analyzes a file and returns the tokens' do
      source = File.dirname(__FILE__) + '/fixtures/source.math'
      
      Lexeme.setup do |lex|
        lex.ruleset = Lexeme::Ruleset.new do |r|
          r.rule 'OPEN',     /^\($/
          r.rule 'CLOS',     /^\)$/
          r.rule 'PLUS',     /^\+$/
          r.rule 'MINUS',    /^\-$/
          r.rule 'MULTI',    /^\*$/
          r.rule 'DIV',      /^\/$/
          r.rule 'NUMBER',   /^\d+\.?\d?$/
          r.rule 'FUNCTION', /^(sqrt|pow|sin|cos|tan)$/
          r.rule 'VAR',      /^\w+\d?$/
        end 
      end
     
      tokens = Lexeme.analyze(source)
      
      expect { tokens[4][0] == 'FUNCTION' && tokens[4][0] == 'sqrt'}.to be_true 
    end
  end
end
