require 'spec_helper'

describe HardwareHelper do
   def mock_collection
     @collection ||= %w(Apple Atari).map do |name|
       mock_model(Manufacturer, :name => name)
     end
   end
     
  describe 'rest_show_link' do
    before do
      @model = mock_model(Manufacturer, :name => 'Apple')
    end
    
    it 'should return a string with a link' do
      helper.rest_show_link(@model).should=~ /<a href=".+">#{@model.name}<\/a>/
    end
    
    it 'should include restful show path for given model' do
      expected_path = manufacturer_path(@model)
      helper.rest_show_link(@model).should include(expected_path)
    end
  end
  
  describe 'links_from_collection' do
    it 'should include rest_show_link for each item in the collection' do
      mock_collection.each do |item|
        helper.links_from_collection(mock_collection).should include(helper.rest_show_link(item))
      end
    end
    
    it 'should join links with commas' do
      links = mock_collection.map{|item| helper.rest_show_link(item)}
      helper.links_from_collection(mock_collection).should == links.join(', ')
    end
  end
  
    describe 'specs_tr_for' do
      
      it 'should include passed title in th tag' do
        title = 'Title'
        helper.specs_tr_for(title, mock_collection).should =~ /<th>#{title}<\/th>/
      end
    
      it 'should include links_from_collection string' do
        helper.specs_tr_for('heading', mock_collection).should include(helper.links_from_collection(mock_collection))
      end
    
      it 'should include a tr tag' do
        helper.specs_tr_for('heading', mock_collection).should =~ /^<tr>.+<\/tr>$/
      end
    end

end
