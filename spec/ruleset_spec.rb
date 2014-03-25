require 'spec_helper'

describe Lexeme::Ruleset do
  subject { Lexeme::Ruleset }
  
  describe '#initialize' do 
    it 'creates an instance' do
      instance = subject.new 

      instance.should be_a Lexeme::Ruleset
    end

    it 'yields control' do 
      expect { |b| subject.new &b }.to yield_control
      expect { |b| subject.new &b }.to yield_with_args(Lexeme::Ruleset)
    end
  end
  
  describe '#rule' do
    it 'adds a new rule criteria' do
      token_params = ['PLUS', /^\+$/]
      ruleset = subject.new

      ruleset.rule(*token_params).pop.should be_a Lexeme::Rule
    end 
  end

  describe '#ignore' do  
    it 'adds ignored token criteria' do  
      ruleset = subject.new
          
      returned = ruleset.ignore /\d/
      returned.should include(/\d/)
    end 
  end

  describe '#ignorable?' do  
    it 'verifes if a char is ignorable' do  
      ruleset = subject.new 
      ruleset.ignore /\s/

      ruleset.ignorable?(' ').should  be_true
      ruleset.ignorable?("\t").should be_true
      ruleset.ignorable?("\n").should be_true
      ruleset.ignorable?('C').should  be_false
    end 
  end
 
  describe '#identifiable?' do 
    it 'identifies a pattern' do
      ruleset = subject.new do |r|
        r.rule 'INT', /\d+/ 
      end

      expected = true
      returned = ruleset.identifiable?('1234')
      returned.should be_true

      expected = false
      returned = ruleset.identifiable?('ABCD')
      returned.should be_true
    end
  end
  
  describe '#identify' do
    it 'identifies a token' do
      ruleset = subject.new do |r|
        r.rule 'FUNCTION', /^sqrt|sin|cos|tan|pow$/
      end

      expected = Lexeme::Token.new('FUNCTION', 'sin', 10)
      returned = ruleset.identify('sin', 10)

      (expected.name == returned.name && expected.value == returned.value).should be_true
    end
  end
end
