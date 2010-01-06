require 'spec_helper'

describe Image do  
  def image_file
    @file ||= fixture_file_upload('rails.png', 'image/png')
  end
  
  describe  'a new blank image' do
    before do
      @image = Image.new
    end
    
    it 'should not be valid' do
      @image.should_not be_valid
    end
    
    it 'should require imageable_id' do
      @image.should have(1).error_on(:imageable_id)
    end
    
    it 'should require imageable_type' do
      @image.should have(1).error_on(:imageable_type)
    end
    
    it 'should require picture_file_name' do
      @image.should have(1).error_on(:picture_file_name)
    end
    
    it 'should require picture_content_type' do
      @image.should have(1).error_on(:picture_content_type)
    end
  end
  
  describe 'a valid image' do
    before do
      @image = Image.new(
        :picture => image_file,
        :imageable => Factory(:hardware)
      )
    end
      
    it 'should be valid' do
      @image.should be_valid
    end
    
    it 'should allow png pictures' do
      @image.stub!(:save_attached_files)
      @image.save.should be_true
    end
  end
end