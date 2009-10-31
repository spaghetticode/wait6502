require 'spec_helper'

describe Image do
  describe  'a new blank image' do
    it 'should not be valid' do
      Image.new.should_not be_valid
    end
    
    it 'should require a original_filename' do
      Image.new.should have(1).error_on(:original_filename)
    end
    
    it 'should require imageable_id' do
      Image.new.should have(1).error_on(:imageable_id)
    end
    
    it 'should require imageable_type' do
      Image.new.should have(1).error_on(:imageable_type)
    end
  end
  
  describe 'a valid image' do
    def image(options={})
      @image ||= Factory(:image, options)
    end
      
    it 'should be valid' do
      image.should be_valid
    end
    
    it 'original_filename should include a datetime stamp' do
      image.original_filename.should =~ /\d{14}/
    end
    
    Image::FORMATS.keys.each do |format|
      it "filename(:#{format}) should include original_filename value" do
        image.filename(format).should include(image.original_filename)
      end
    
      it "filename(:#{format}) should include \"#{format}\" directory" do
        image.filename(format).should include("/#{format}/")
      end
    end
    
    it 'filename should include FS_PREFIX when requested' do
      image.filename(:normal, :fs).should include(Image::FS_PREFIX)
    end
    
    it 'title should return associated imageable name when title is not explictly set' do
      image.update_attribute(:title, '')
      image.title.should == image.imageable.name
    end
  end
end