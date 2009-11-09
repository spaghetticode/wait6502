require 'spec_helper'

module ImageUploadedFileHelper
  def valid_file
    @valid_file ||= mock_image_file(:valid => true)
  end
  
  def invalid_file
    @invalid_file ||= mock_image_file(:valid => false)
  end
  
  def mock_image_file(options)
    returning ActionController::UploadedStringIO.new(File.read("#{RAILS_ROOT}/public/images/rails.png")) do |file|
      content_type = options[:valid] ? 'image/jpg' : 'text/txt'
      file.stub!(
        :content_type => content_type,
        :original_filename => 'image file.png'
      )
    end
  end
end

describe Image do
  include ImageUploadedFileHelper
  
  describe  'a new blank image' do
    it 'should not be valid' do
      Image.new.should_not be_valid
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
      @image ||= Factory(:image, options.merge(:uploaded_file => valid_file))
    end
    
    after do
      Image::FORMATS.keys.push(:original).each do |directory|
        system "rm -rf #{Image::FS_PREFIX}/#{directory}/*"
      end
    end
      
    it 'should be valid' do
      image.should be_valid
    end
    
    it 'original_filename should include a datetime stamp' do
      image.original_filename.should =~ /\d{14}/
    end
    
    it 'original_filename should include uploaded file filename' do
      image.original_filename.should include(valid_file.original_filename)
    end
    
    it 'should create a thumbnail size image' do
      File.file?(image.filename(:thumb, :fs)).should be_true
    end
    
    it 'should create a small size image' do
      File.file?(image.filename(:small, :fs)).should be_true
    end
    
    it 'should create a normal size image' do
      File.file?(image.filename(:normal, :fs)).should be_true
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
    
    it 'should destroy thumbnail size image' do
      image.destroy
      File.file?(image.filename(:thumb, :fs)).should be_false
    end
    
    it 'should destroy small size image' do
      image.destroy
      File.file?(image.filename(:small, :fs)).should be_false
    end
    
    it 'should destroy normal size image' do
      image.destroy
      File.file?(image.filename(:normal, :fs)).should be_false
    end
  end
end