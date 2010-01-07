require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Manufacturer do
  describe 'a new blank instance' do
    describe 'should require a unique name' do
      before do
        @class = Manufacturer
      end
      
      include NameUniqueRequired
    end

    before do
      @manufacturer = Manufacturer.new
    end
        
    it 'should have hardware association' do
      @manufacturer.hardware.should_not be_nil
    end
    
    it 'should have cpus association' do
      @manufacturer.cpus.should_not be_nil
    end
    
    it 'should have co_cpus association' do
      @manufacturer.co_cpus.should_not be_nil
    end
    
    it 'should use paperclip to store logo picture' do
      @manufacturer.logo.should be_a(Paperclip::Attachment)
    end
    
    it 'should have a default image' do
      @manufacturer.logo.to_s.should include('blank_manufacturer.jpg')
    end
    
    context 'when uploading an image' do
      before do
        @logo = fixture_file_upload('rails.png', 'image/png')
        @manufacturer = Manufacturer.new(
          Factory.attributes_for(:manufacturer).merge(:logo => @logo)
        )
      end
      
      it 'should allow png logos' do
        @manufacturer.stub!(:save_attached_files)
        @manufacturer.save.should be_true
      end
      
      it 'should have expected logo filename' do
        @manufacturer.stub!(:id => 10) 
        expected = "manufacturers/#{@manufacturer.id}/logo.png"
        @manufacturer.logo.to_s.should include(expected)
      end
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      Factory(:manufacturer).should be_valid
    end
    
    it 'should have an associated country' do
      Factory(:manufacturer).country.should be_a(Country)
    end
    
  end
  
  describe 'named scope ORDERED' do
    before do
      5.times {Factory(:manufacturer)}
    end
    
    it 'should sort manufacturers by name' do
      Manufacturer.ordered.should == Manufacturer.all.sort_by(&:name)
    end
  end
  
  describe 'ILIKE_STRING' do
    it 'should include ILIKE ? string' do
      Manufacturer.ilike_string.should include('ILIKE ?')
    end
    
    it 'should include a COALESCE function for each search field' do
      Manufacturer::SEARCH_FIELDS.values.each do |field|
        Manufacturer.ilike_string.should include("COALESCE(#{field}, '')")
      end
    end
    
    it 'should join COALESCE functions with || ' do
      Manufacturer.ilike_string.should include(' || ')
    end
  end
end
