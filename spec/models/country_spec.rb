require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Country do
  describe 'a new blank instance' do
    before :all do
      @class = Country
    end

    include NaturalKeyTable
    
    it 'should have manufacturers association' do
      @class.new.manufacturers.should == []
    end
    
    describe 'when no image is uploaded' do
      before do
        @country = Country.new
      end
      
      it 'should be unused' do
        @country.should be_unused
      end
      
      it 'should have a paperclip flag image' do
        @country.flag.should be_a(Paperclip::Attachment)
      end
      
      it 'should have a default flag image' do
        @country.flag.to_s.should include('missing.png')
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
  
    describe 'when associations are not empty' do
      it 'should not be unused' do
        %w[manufacturers original_prices ebay_sites].each do |association|
          klass = association.singularize.camelize.constantize
          @country.stub!(association => [mock_model(klass)])
          @country.should_not be_unused
        end
      end
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
