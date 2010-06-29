require 'spec_helper'

describe Auction do
  def image_file
    @file ||= fixture_file_upload('rails.png', 'image/png')    
  end
  
  context 'a new blank instance' do
    it 'should not be valid' do
      Auction.new.should_not be_valid
    end
    
    it 'should require a hardware' do
      Auction.new.should have(1).error_on(:hardware)
    end
    
    it 'should require a currency' do
      Auction.new.should have(1).error_on(:currency)
    end
    
    it 'should require a ebay_site' do
      Auction.new.should have(1).error_on(:ebay_site)
    end
    
    it 'should require cosmetic_conditions' do
      Auction.new.should have_at_least(1).error_on(:cosmetic_conditions)
    end
    
    it 'should require completeness' do
      Auction.new.should have_at_least(1).error_on(:completeness)
    end
    
    it 'should require end_time' do
      Auction.new.should have(1).error_on(:end_time)
    end
    
    it 'should require a item_id' do
      Auction.new.should have_at_least(1).error_on(:item_id)
    end
    
    it 'should require a url' do
      Auction.new.should have_at_least(1).error_on(:url)
    end
    
    it 'should require a valid completeness' do
      Auction.new(:completeness => 'invalid value').should have(1).error_on(:completeness)
    end
    
    it 'should require a  valid cosmetic_conditions' do
      Auction.new(:cosmetic_conditions => 'invalid value').should have(1).error_on(:cosmetic_conditions)
    end
    
    it 'should have expected associations' do
      %w{hardware ebay_site currency}.each do |association|
        Auction.new.should respond_to(association)
      end
    end
    
    it 'should have a default blank picture' do
      Auction.new.picture.to_s.should == Auction::BLANK_IMAGE_URL
    end
    
    it 'should have a unique url' do
      Auction.stub!(:before_create)
      auction = Factory(:auction)
      invalid = Auction.new(:url => auction.url)
      invalid.should have(1).error_on(:url)
    end
    
    it 'should have a unique item_id' do
      auction = Factory(:auction)
      invalid = Auction.new(:item_id => auction.item_id)
      invalid.should have(1).error_on(:item_id)
    end
  end

  context 'an auction with valid attributes' do
    it 'should be valid' do
      Factory(:auction).should be_valid
    end
  end

  describe 'a valid auction' do
    before do
      @auction = Factory(:auction)
    end
    
    context 'when it has not ended yet' do
      before do
        @auction = Factory(:auction)
      end
      
      it 'should not be closed' do
        @auction.should_not be_closed
      end
      
      it 'final_price attribute should be nil' do
        @auction.final_price.should be_nil
      end
    end
    
    context 'when it has already ended' do
      before do
        @auction.end_time = Time.now.yesterday
      end
      
      it 'should be closed' do
        @auction.should be_closed
      end
      
      it 'should be recent if auction ended less than 90 days ago' do
        @auction.should be_recent
      end
       
      it 'should not be recent if auction ended more than 90 days ago' do
        @auction.end_time = 91.days.ago
        @auction.should_not be_recent
      end

      describe 'calling SET_FINAL_PRICE' do
        describe 'when auction went without bids' do
          before do
            unsold_item = mock(:bid_count => 0)
            @auction.should_receive(:find_ebay_item).and_return(unsold_item)
          end
        
          it 'final_price attribute should not change' do
            lambda do
              @auction.set_final_price
            end.should_not change(@auction, :final_price)
          end
        end
        
        describe 'when auction received at least 1 bid' do
          describe 'calling set_final_price' do
            before do
              sold_item = mock(:bid_count => 1, :current_price => EbayFinder::Money.new(:amount => 10.0, :currency_id => 'USD'))
              @auction.should_receive(:find_ebay_item).and_return(sold_item)
            end

            it 'should change final_price attribute' do
              lambda do
                @auction.set_final_price
              end.should change(@auction, :final_price)
            end
          end
        end
      end
    end
  end 

  describe 'creating a new auction' do    
    context 'when ebay auction has no gallery image' do
      it 'picture.to_s should return default image path' do
        File.should_not_receive(:open)
        auction = Factory(:auction)
        auction.picture.to_s.should == Auction::BLANK_IMAGE_URL
      end
    end
  end
  
  describe 'TESTING NAMED SCOPES' do
    describe 'ORDERED' do
      it 'should sort auctions by creation time' do
        2.times {Factory(:auction)}
        Auction.ordered.should == Auction.all.sort_by(&:created_at)
      end
    end
    
    describe 'ACTIVE, CLOSED' do
      before do
        3.times {Factory(:auction)}
        Auction.last.update_attribute(:end_time, Time.now.yesterday)
      end
      
      it 'active should select only active auctions' do
        Auction.active.each do |auction|
          auction.should_not be_closed
        end
      end
      
      it 'closed should select only closed auctions' do
        Auction.closed.each do |auction|
          auction.should be_closed
        end
      end
    end
    
    describe 'SOLD_IN' do
      before do
        italy = mock_model(EbaySite, :name => 'IT', :currency_id => 'EUR')
        3.times {Factory(:auction)}
        Auction.last.update_attributes(
          :ebay_site_id => 'IT',
          :final_price => 33.0
        )
      end
      
      it 'should select only expected auctions' do
        Auction.sold_in('IT').each do |auction|
          auction.ebay_site_id.should == 'IT'
          auction.final_price.should_not be_nil
        end
      end
    end
    
    describe 'COSMETIC_CONDITIONS related named scopes' do
      before do
        Auction::COSMETIC_CONDITIONS.each do |conditions|
          Factory(:auction, :cosmetic_conditions => conditions)
        end
      end
      
      describe 'POOR' do
        it 'should select auctions with poor cosmetic conditions' do
          Auction.poor.should == Auction.all(:conditions => {:cosmetic_conditions => 'poor'})
        end
      end
      
      describe 'AVERAGE' do
        it 'should select auctions with average cosmetic_conditions' do
          Auction.average.should == Auction.all(:conditions => {:cosmetic_conditions => 'average'})
        end
      end
    end
    
    describe 'COMPLETENESS related named scopes' do
      before do
        Auction::COMPLETENESSES.each do |completeness|
          Factory(:auction, :completeness => completeness)
        end
        
        describe 'BOXED_WITH_EXTRAS' do
          it 'should select auctions with box with extras completeness' do
            Auction.boxed_with_extras.should == Auction.all(:conditions => {:completeness => 'boxed with extras'})
          end
        end
        
        describe 'BARE' do
          it 'should select auctions with bare completeness' do
            Auction.bare.should == Auction.all(:conditions => {:completeness => 'bare'})
          end
        end
      end
    end
    
    describe 'testing named scopes combinations' do
      describe 'when there are 3 bare and poor conditions auctions' do
        before do
          3.times {Factory(:auction, :completeness => 'bare', :cosmetic_conditions => 'poor')}
        end
      
        it 'BARE + POOR combination should select all auctions' do
          Auction.bare.poor.should  == Auction.all
        end
      
        it 'BARE + AVERAGE should select no auction' do
          Auction.average.complete.should have(0).auctions
        end
      end
    end
  end
  
  describe 'item_ids class method' do
    it 'should return an array' do
      Auction.item_ids.should be_an(Array)
    end
    
    it 'should include all auctions item_id' do
      3.times {Factory(:auction)}
      Auction.all.each do |auction|
        Auction.item_ids.should include(auction.item_id)
      end
    end
  end
  
  describe 'self.ILIKE_STRING' do
    it 'should include ILIKE ? string' do
      Auction.ilike_string.should include('ILIKE ?')
    end
    
    it 'should include a COALESCE function for each search field' do
      Auction::SEARCH_FIELDS.values.each do |field|
        Auction.ilike_string.should  =~ /COALESCE(.*#{field})/
      end
    end
    
    it 'should join COALESCE functions with || ' do
      Auction.ilike_string.should include(' || ')
    end
  end
end
