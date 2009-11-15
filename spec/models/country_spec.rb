require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Country do
  describe 'a new blank instance' do
    before :all do
      @class = Country
    end

    include NaturalKeyTable

    describe 'when no image is uploaded' do
      before do
        @country = Country.new
      end
      
      it 'should not validate image content type' do
        @country.should_not_receive(:validate_file_format)
        @country.save
      end
      
      it 'flag_image_filename should be nil' do
        @country.flag_image_filename.should be_nil
      end
    end
    
    describe 'when uploading an image' do
      it 'flag filename should be 2 letters lowercase' do
        %w{AZ Uk China china}.each do |invalid|
          country = @class.new(:flag_filename => invalid)
          country.valid?
          country.errors.on(:flag_filename).should == 'is invalid'
        end
      end
      
      it 'should check image file contet type' do
        country = @class.new(:flag_filename => 'us')
        country.should_receive(:validate_file_format)
        country.save
      end
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      Factory(:country).should be_valid
    end
    
    it 'should have id same as name (name is primary key)' do
      country = Factory(:country)
      country.id.should == country.name
    end
    
    it 'should have manufacturers association' do
      Country.new.manufacturers.should == []
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
