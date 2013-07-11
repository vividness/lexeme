require 'spec_helper'

describe String do
  subject { 'My name is Inigo Montoya!' }
  
  describe '#to_tokens' do
    it 'tokenizes a string' do
      tokens = subject.to_tokens

      tokens[0].value.should be_eql 'My'
      tokens[2].value.should be_eql 'is'
      tokens[4].value.should be_eql 'Montoya'
      tokens[-1].value.should be_eql '!'
    end
  end
end
