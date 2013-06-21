require 'spec_helper'

describe Lexeme::Rule do 
 describe '#initialize' do 
  subject { Lexeme::Rule }

  it 'raises argument error on no params' do
    expect { subject.new }.to raise_error(ArgumentError)
  end

  it 'raises error on one param only' do
    expect { subject.new('RULE') }.to raise_error(ArgumentError)
  end
  
  it 'raises error on invalid param type' do
    expect { subject.new('RULE', '')}.to raise_error(ArgumentError)
    expect { subject.new('RULE', 1)}.to raise_error(ArgumentError)
    expect { subject.new(//, //)}.to raise_error(ArgumentError)
    expect { subject.new(//, '')}.to raise_error(ArgumentError)
    expect { subject.new(//, 1)}.to raise_error(ArgumentError)
    expect { subject.new(1, '')}.to raise_error(ArgumentError)
    expect { subject.new(1, 1)}.to raise_error(ArgumentError)
    expect { subject.new(1, //)}.to raise_error(ArgumentError)
  end

  it 'creates an instance' do 
    rule = subject.new('RULE', /\w/)
    
    rule.should be_a Lexeme::Rule
  end
 end

 describe '#name' do 
  subject { Lexeme::Rule.new('TEST_RULE', /[A-Za-z0-9]+/) }
  it "returns rule's name" do
    subject.name.should be_eql 'TEST_RULE' 
  end
 end
 
 describe '#regex' do 
  subject { Lexeme::Rule.new('TEST_RULE', /[A-Za-z0-9]+/) }
  it "returns rule's name" do
    subject.regex.should be_eql /[A-Za-z0-9]+/
  end
 end
end
