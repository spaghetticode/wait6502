require File.dirname(__FILE__) + '/../../../../spec/spec_helper'

describe String do
  describe '#downcase_first_letter' do
    it 'should downcase only first letter' do
      examples = {
        'Andrea' => 'andrea',
        'ANDREA' => 'aNDREA',
        'andrea' => 'andrea',
        ''       => ''
      }
      examples.each do |string, expected|
        string.downcase_first_letter.should == expected
      end
    end
  end
  
  describe '#ebay_camelize' do
    it 'should return expected string' do
      %w{foo_bar fooBar}.each do |string|
        string.ebay_camelize.should == 'fooBar'
      end
    end
  end
end

describe Hash do
  describe '#ebay_parametrize' do
    before do
      @expected_params = [
        'categoryId=1234',
        'priceData.currency=USD',
        'priceData.currencyAmount=1000',
        'keyword=first%20keyword'
      ]
      @params_hash ={
        :keyword => 'first keyword',
        :category_id => 1234,
        :price_data => 
        {:currency => 'USD', :currency_amount => 1000}
      }
    end
    
    it 'should include expected params' do
      @expected_params.each do |param|
        @params_hash.ebay_parametrize.should include(param)
      end
    end
  
    it 'should join params with "&"' do
      params_string = @params_hash.ebay_parametrize
      @expected_params.each do |param|
        params_string.gsub!(param, 'placeholder')
      end
      expected = (%w{placeholder}* @expected_params.size).join('&')
      params_string.should == expected
    end
  end
end