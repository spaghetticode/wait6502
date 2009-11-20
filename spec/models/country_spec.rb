require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Country do
  
  def mock_image_file(options)
    file = File.read("#{RAILS_ROOT}/public/images/rails.png")
    returning ActionController::UploadedStringIO.new(file) do |file|
      content_type = options[:valid] ? 'image/jpg' : 'text/txt'
      file.stub!(
        :content_type => content_type,
        :original_filename => 'image file.png'
      )
    end
  end
    
  describe 'a new blank instance' do
    before :all do
      @class = Country
    end

    include NaturalKeyTable
    
    it 'should have manufacturers association' do
      Country.new.manufacturers.should == []
    end
    
    describe 'when no image is uploaded' do
      before do
        @country = Country.new
      end
      
      it 'should not validate image content type' do
        @country.should_not_receive(:validate_flag_format)
        @country.save
      end
      
      it 'flag should be nil' do
        @country.flag.should be_nil
      end
      
      it 'flag_filename should be nil' do
        @country.flag_filename.should be_nil
      end
    end
    
    describe 'when uploading an image' do
      it 'should check image file contet type' do
        country = @class.new(:name => 'China', :flag_file => mock_image_file(:valid => true))
        country.should_receive(:validate_flag)
        country.save
      end
      
      it 'validates_flag should return false when image is not a png file' do
        country = @class.new(:name => 'China', :flag_file => mock_image_file(:valid => false))
        country.should_receive(:validate_flag).and_return(false)
        country.save
      end
      
      it 'should save image' do
        country = @class.new(:name => 'China', :flag_file => mock_image_file(:valid => true))
        country.save
        country.should have_flag
      end
    end
  end
  
  describe 'an instance with valid attributes' do
    before do
      @country = Factory(:country)
    end
    
    it 'should be valid' do
      @country.should be_valid
    end
    
    it 'should have id same as name (name is primary key)' do
      @country.id.should == @country.name
    end
    
    it 'flag_filename should not be nil' do
     @country.flag_filename.should_not be_nil
    end
  end
  
  describe 'named scope ORDERED' do
    before do
      5.times {Factory(:country)}
    end
    
    it 'should sort countries by name' do
      Country.ordered.should == Country.all.sort_by(&:name)
    end
  end
end
