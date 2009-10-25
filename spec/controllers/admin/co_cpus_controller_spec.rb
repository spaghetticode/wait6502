require 'spec_helper'

module CoCpusControllerHelper
  def mock_co_cpu(options={})
   @mock ||= mock_model(CoCpu, options)
  end
  
  def delete_destroy
    delete :destroy, :id => '1'
  end
  
  def post_create
    post :create, :co_cpu => {}
  end
  
  def put_update
    put :update, :id => '1', :co_cpu => {}
  end
end

describe Admin::CoCpusController do
  include CoCpusControllerHelper

  describe 'WITHOUT BEING AUTHENTICATED' do
    should_flash_and_redirect_for(
      :new => :get,
      :index => :get,
      :edit => :get,
      :create => :post,
      :update => :put,
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
      
      it 'should render index template' do
        response.should render_template(:index)
      end
      
      it 'should assign @co_cpus' do
        assigns[:co_cpus].should_not be_nil
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
      
      it 'should assign @co_cpu' do
        assigns[:co_cpu].should_not be_nil
      end
      
      it 'assigns[:co_cpu] should be new_record' do
        assigns[:co_cpu].should be_new_record
      end
    end
    
    describe 'GET EDIT' do
      before do
        CoCpu.should_receive(:find).and_return(mock_co_cpu)
        get :edit, :id => '1'
      end
      
      it 'should be success' do
        response.should be_success
      end
      
      it 'should render edit template' do
        response.should render_template(:edit)
      end
      
      it 'should assign @co_cpu' do
        assigns[:co_cpu].should_not be_nil
      end
    end
   
   describe 'POST CREATE' do
     describe 'with valid parameters' do
       before do
         CoCpu.should_receive(:new).and_return(mock_co_cpu(:save => true))
         post_create
       end
       
       it 'should redirect to admin_co_cpus_path' do
         response.should redirect_to(admin_co_cpus_path)
       end
       
       it 'should flash' do
         flash[:notice].should_not be_nil
       end
       
       it 'should assign @co_cpu' do
         assigns[:co_cpu].should_not be_nil
       end
     end
     
     describe 'with invalid attributes' do
       before do
         CoCpu.should_receive(:new).and_return(mock_co_cpu(:save => false))
         post_create
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
       
       it 'should assign @co_cpu' do
         assigns[:co_cpu].should_not be_nil
       end
     end
    end
    
    describe 'PUT UPDATE' do
      describe 'with valid parameters' do
        before do
          CoCpu.should_receive(:find).and_return(mock_co_cpu(:update_attributes => true))
          put_update
        end
      
        it 'should redirect to admin_co_cpus_path' do
          response.should redirect_to(admin_co_cpus_path)
        end
      
        it 'should flash' do
          flash[:notice].should_not be_nil
        end
      
        it 'should assign @co_cpu' do
          assigns[:co_cpu].should_not be_nil
        end
      end
      
      describe 'with invalid parameters' do
        before do
          CoCpu.should_receive(:find).and_return(mock_co_cpu(:update_attributes => false))
          put_update
        end
        
        it 'should be success' do
          response.should be_success
        end
        
        it 'should render edit template' do
          response.should render_template(:edit)
        end
        
        it 'should not flash' do
          flash[:notice].should be_nil
        end
      end
    end
    
    describe 'DELETE DESTROY' do
      describe 'when co-cpu has no computer associated' do
        before do
          CoCpu.should_receive(:find).and_return(mock_co_cpu(:computers => []))
          mock_co_cpu.should_receive(:destroy)
          delete_destroy
        end
      
        it 'should redirect to admin_co_cpus_path' do
          response.should redirect_to(admin_co_cpus_path)
        end
      
        it 'should flash' do
          flash[:notice].should_not be_nil
        end
      end
      
      describe 'when co-cpu has at least one associated computer' do
        before do
          CoCpu.should_receive(:find).and_return(mock_co_cpu(:computers => [mock_model(Computer)]))
          mock_co_cpu.should_not_receive(:destroy)
          delete_destroy
        end
          
        it 'should redirect to admin_co_cpus_path' do
          response.should redirect_to(admin_co_cpus_path)
        end
        
        it 'should flash[:error]' do
          flash[:error].should_not be_nil
        end
      end
    end
  end 
end