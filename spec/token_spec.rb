require 'spec_helper'

describe Lexeme::Token do
  subject { Lexeme::Token.new('INT', '1234') }
  
  describe '#initialize' do
    it 'properly sets up an object' do
      subject.should be_a Lexeme::Token
    end
  end

  describe '#to_text' do
    it 'returns token as text' do
      subject.to_text.should be_eql 'INT: 1234'
    end
  end

  describe '#to_array' do
    it 'returns token as array' do
      subject.to_array.should == ['INT', '1234']
    end
  end
end
