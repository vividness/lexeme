require 'spec_helper'

describe Lexeme do
  describe '#setup' do 
    it 'yields a new Lexeme object' do
      expect { |b| Lexeme.setup &b }.to yield_control
      expect { |b| Lexeme.setup &b }.to yield_with_args(Lexeme::Lexeme)
    end
  end
  
  describe '#define' do
    it 'returns Lexeme object' do
      Lexeme.define { token :ANY => /^.*$/ }.should be_a Lexeme::Lexeme
    end
  end
  
  describe '#analyze' do 
    it 'raise an error if called before #setup' do
      Lexeme.setup
      
      expect { subject.analyze }.to raise_error(ArgumentError)
    end

    it 'raise an erorr if source file cannot be found' do
      Lexeme.setup
      expect { Lexeme.analyze '/root/surce.math' }.to raise_error(RuntimeError)
    end
    
    it 'tokenize a math formulas source' do
      source = File.join(File.dirname(__FILE__), '/fixtures/source.math')
      
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
     
      tokens = Lexeme.analyze do 
        from_file source
      end
      
      returned = tokens[4].name.eql?('FUNCTION') && tokens[4].value.eql?('sqrt')
      returned.should be_true 
    end

    it 'tokenize a program language pseudo code' do
      source = File.join(File.dirname(__FILE__), '/fixtures/source.pseudo')
      
      Lexeme.setup do |lex|
        lex.ruleset = Lexeme::Ruleset.new do |g| 
          g.rule 'EQ',       /^=$/
          g.rule 'PLUS',     /^\+$/
          g.rule 'MINUS',    /^\-$/
          g.rule 'MULTI',    /^\*$/
          g.rule 'DIV',      /^\/$/
          g.rule 'NUMBER',   /^\d+\.?\d?$/
          g.rule 'RESERVED', /^(fin|print|func|)$/
          g.rule 'STRING',   /^".*"$/
          g.rule 'ID',       /^[\w_"]+$/
        end
      end

      tokens = Lexeme.analyze do 
        from_file source
      end
      
      returned = tokens[-1].name.eql?('RESERVED') && tokens[-1].value.eql?('fin')
      returned.should be_true
    end

    it 'tokenizes a human language sentence' do 
      Lexeme.define do
        token :STOP     =>   /^\.$/
        token :COMA     =>   /^,$/
        token :QUES     =>   /^\?$/
        token :EXCLAM   =>   /^!$/
        token :QUOT     =>   /^"$/
        token :APOS     =>   /^'$/
        token :WORD     =>   /^[\w\-]+$/
      end
      
      tokens = Lexeme.analyze do  
        # ref: http://www.youtube.com/watch?v=6JGp7Meg42U 
        from_string 'Hello! My name is Inigo Montoya. You killed my father. Prepare to die.'
      end
      
      "#{tokens[0].name}: #{tokens[0].value}".should    be_eql 'WORD: Hello'
      "#{tokens[1].name}: #{tokens[1].value}".should    be_eql 'EXCLAM: !'
      "#{tokens[-1].name}: #{tokens[-1].value}".should  be_eql 'STOP: .'
    end
  end
end
