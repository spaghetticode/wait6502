require 'spec_helper'

describe Image do
  describe  'a new blank image' do
    it 'should not be valid' do
      Image.new.should_not be_valid
    end
    
    it 'should require a original_filename' do
      Image.new.should have(1).error_on(:original_filename)
    end
    
    it 'should require a uploaded_file' do
      Image.new.should have(1).error_on(:uploaded_file)
    end
  end
end