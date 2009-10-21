require 'spec_helper'

module CpusControllerHelper
  def mock_cpu(options)
    mock_model(Cpu, options)
  end
  
  def post_create
    post :create, :cpu => {}
  end
end

describe Admin::CpusController do
  include CpusControllerHelper
  
  describe 'WITHOUT BEING AUTHENTICATED' do
    should_flash_and_redirect_for(
      :new => :get,
      :index => :get,
      :create => :post,
      :destroy => :delete
    )
  end
  
  describe 'BEING AUTHENTICATED' do
    before do
      activate_authlogic
      UserSession.create!(Factory(:user))
    end
    
    describe 'GET INDEX' do
      before do
        get :index
      end
    
      it 'should be success' do
        response.should be_success
      end
    
      it 'should render new template' do
        response.should render_template(:index)
      end
    
      it 'should assign @cpus' do
        assigns[:cpus].should_not be_nil
      end
    end
  
    describe 'GET NEW' do
      before do
        get :new
      end
    
      it 'should be success' do
        response.should be_success
      end
    
      it 'should render new template' do
        response.should render_template(:new)
      end
    
      it 'should assign @cpu' do
        assigns[:cpu].should_not be_nil
      end
    
      it 'should assign a new record to @cpu' do
        assigns[:cpu].should be_new_record
      end
    end
  
    describe 'POST CREATE' do
      describe 'with valid attributes' do
        before do
          Cpu.should_receive(:new).and_return(mock_cpu(:save => true))
          post_create
        end
      
        it 'should flash' do
          flash[:notice].should == 'CPU was successfully created.'
        end
      
        it 'should redirect to admin_cpus_path' do
          response.should redirect_to(admin_cpus_path)
        end
      
        it 'should assign @cpu' do
          assigns[:cpu].should_not be_nil
        end
      end
    
      describe 'with invalid attributes' do
        before do
          Cpu.should_receive(:new).and_return(mock_cpu(:save => false))
          post_create
        end
        it 'should render new template' do
          response.should render_template(:new)
        end
      
        it 'should assign @cpu' do
          assigns[:cpu].should_not be_nil
        end
      end
    end
  
    describe 'DELETE DESTROY' do
      before do
        Cpu.should_receive(:find).and_return(mock_cpu(:destroy => nil))
        delete :destroy, :id => '1'
      end
    
      it 'should flash' do
        flash[:notice].should == 'CPU was successfully destroyed.'
      end
    
      it 'should redirect to admin_cpus_path' do
        response.should redirect_to(admin_cpus_path)
      end
    end
  end
end
