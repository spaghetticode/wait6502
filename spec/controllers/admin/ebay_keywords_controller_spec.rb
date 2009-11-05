require 'spec_helper'

describe Admin::EbayKeywordsController do
  def mock_ebay_keyword(options={})
    @mock ||= mock_model(EbayKeyword, options)
  end
  
  def searchable(options={})
    ebay_keywords = []
    ebay_keywords.stub!(:build => mock_ebay_keyword, :ordered => [])
    @searchable ||= mock_model(Hardware, options.merge(:ebay_keywords => ebay_keywords, :class_name => 'Hardware', :name => 'Hardware Name'))
  end
  
  describe 'without being authenticated' do
    should_flash_and_redirect_for(
      {
      :index => :get,
      :new => :get,
      :create => :post,
      :destroy => :delete
      },
      :hardware_id => '1'
    )
  end
  
  describe 'being authenticated' do
    before do
      activate_authlogic
      UserSession.create!(Factory(:user))
      Hardware.should_receive(:find).and_return(searchable)
    end
    
    describe 'GET INDEX' do
      before do
        get :index, :hardware_id => '1'
      end
      
      it 'should be success' do
        response.should be_success
      end
      
      it 'should render index template' do
        response.should render_template(:index)
      end
      
      it 'should assign @ebay_keywords' do
        assigns[:ebay_keywords].should_not be_nil
      end
    end
    
    describe 'GET NEW' do
      before do
        get :new, :hardware_id => '1'
      end
      
      it 'should be success' do
        response.should be_success
      end
      
      it 'should render new template' do
        response.should render_template(:new)
      end
      
      it 'should assign @ebay_keyword' do
        assigns[:ebay_keyword].should_not be_nil
      end
    end
    
    describe 'POST CREATE' do
      describe 'with valid attributes' do
        before do
          mock_ebay_keyword.should_receive(:save).and_return(:true)
          post :create, :hardware_id => '1', :ebay_keyword => {}
        end
        
        it 'should redirect to associated searchable ebay_keywords page' do
          response.should redirect_to(admin_hardware_ebay_keywords_path(searchable))
        end
        
        it 'should flash' do
          flash[:notice].should == 'Ebay Keyword was successfully created.'
        end
        
        it 'should assign @ebay_keyword' do
          assigns[:ebay_keyword].should_not be_nil
        end
      end
      
      describe 'with invalid attributes' do
        before do
          mock_ebay_keyword.should_receive(:save).and_return(false)
          post :create, :hardware_id => '1', :ebay_keyword => {}
        end
        
        it 'should be success' do
          response.should be_success
        end
        
        it 'should render new template' do
          response.should render_template(:new)
        end
        
        it 'should not flash' do
          flash[:notice].should be_nil
        end
        
        it 'should assign @ebay_keyword' do
          assigns[:ebay_keyword].should_not be_nil
        end
      end
      
      describe 'DELETE DESTROY' do
        before do
          searchable.ebay_keywords.should_receive(:destroy)
          delete :destroy, :id => '1', :hardware_id => '1'
        end
        
        it 'should redirect to associated searchable ebay_keywords page' do
          response.should redirect_to(admin_hardware_ebay_keywords_path(searchable))
        end
        
        it 'should flash' do
          flash[:notice].should == 'Ebay Keyword was successfully destroyed.'
        end
      end
    end
  end
end
