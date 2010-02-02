require 'spec_helper'

describe Letter do
  context 'a new blank istance' do
    before do
      @letter = Letter.new
    end
    
    it 'should not be valid' do
      @letter.should_not be_valid
    end
    
    it 'should require a name' do
      @letter.should have(1).error_on(:name)
    end
    
    it 'should have a unique name' do
      valid = Factory(:letter)
      Letter.new(:name => valid.name).should have(1).error_on(:name)
    end
    
    it 'should have an hardware association' do
      @letter.hardware.should_not be_nil
    end
  end
end
