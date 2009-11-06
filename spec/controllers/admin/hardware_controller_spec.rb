require 'spec_helper'

module HardwareControllerHelper
  def mock_hardware(options={})
    @mock ||= mock_model(Hardware, options)
  end
  
  def post_create
    post :create, :hardware => {}
  end
  
  def put_update
    put :update, :id => '1', :hardware => {}
  end
end
describe Admin::HardwareController do
  include HardwareControllerHelper

  describe 'without being logged in' do
    should_flash_and_redirect_for(
      :index => :get,
      :new => :get,
      :edit => :get,
      :create => :post,
      :update => :put,
      :destroy => :delete,
      :add_cpu => :post,
      :add_builtin_storage => :post,
      :add_operative_system => :post,
      :add_cpu => :post,
      :add_io_port => :post,
      :remove_cpu => :delete,
      :remove_co_cpu => :delete,
      :remove_builtin_storage => :delete,
      :remove_operative_system => :delete,
      :remove_io_port => :delete
    )
  end
  
  describe 'being logged in' do
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
      
      it 'should assign @hardware' do
        assigns[:hardware].should_not be_nil
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
      
      it 'should assign @hardware' do
        assigns[:hardware].should_not be_nil
      end
    end
    
    describe 'GET EDIT' do
      before do
        Hardware.should_receive(:find).and_return(mock_hardware)
        get :edit, :id => '1'
      end
      
      it 'should be success' do
        response.should be_success
      end
      
      it 'should render edit template' do
        response.should render_template(:edit)
      end
      
      it 'should assign @hardware' do
        assigns[:hardware].should_not be_nil
      end
    end
    
    describe 'POST CREATE' do
      describe 'with valid parameters' do
        before do
          Hardware.should_receive(:new).and_return(mock_hardware(:save => true))
          post_create
        end

        it 'should redirect to edit page' do
          response.should redirect_to(edit_admin_hardware_path(mock_hardware))
        end

        it 'should flash' do
          flash[:notice].should_not be_nil
        end

        it 'should assign @hardware' do
          assigns[:hardware].should_not be_nil
        end
      end

      describe 'with invalid attributes' do
        before do
          Hardware.should_receive(:new).and_return(mock_hardware(:save => false))
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

        it 'should assign @hardware' do
          assigns[:hardware].should_not be_nil
        end
      end
    end

    describe 'PUT UPDATE' do
       describe 'with valid parameters' do
         before do
           Hardware.should_receive(:find).and_return(mock_hardware(:update_attributes => true))
           put_update
         end

         it 'should redirect to edit page' do
           response.should redirect_to(edit_admin_hardware_path(mock_hardware))
         end

         it 'should flash' do
           flash[:notice].should_not be_nil
         end

         it 'should assign @hardware' do
           assigns[:hardware].should_not be_nil
         end
       end

       describe 'with invalid parameters' do
         before do
           Hardware.should_receive(:find).and_return(mock_hardware(:update_attributes => false))
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
      before do
        mock_hardware.should_receive(:destroy)
        Hardware.should_receive(:find).and_return(mock_hardware)
        delete :destroy, :id => '1'
      end
    
      it 'should redirec to hardware list page' do
        response.should redirect_to(admin_hardware_index_path)
      end
    
      it 'should flash' do
        flash[:notice].should =~ /successfully destroyed/
      end
    end
    
    describe 'POST ADD_CPU' do
      before do
        @cpus = []
        Hardware.should_receive(:find).and_return(mock_hardware(:cpus => @cpus))
      end
      
      describe 'when CPU is not associated to hardware yet' do
        before do
          @cpus.should_receive(:find_by_id).and_return(nil)
          Cpu.should_receive(:find).and_return(mock_model(Cpu))
          post :add_cpu, :cpu_id => '1', :id => '1'
        end
      
        it 'should redirect to edit page' do
          response.should redirect_to(edit_admin_hardware_path(mock_hardware))
        end
        
        it 'should flash' do
          flash[:notice].should =~ /successfully added/
        end
      end
      
      describe 'when CPU is already associated to hardware' do
        before do
          @cpus.should_receive(:find_by_id).and_return(true)
          post :add_cpu, :id => '1', :cpu_id => '1'
        end
        
        it 'should redirect to edit page' do
          response.should redirect_to(edit_admin_hardware_path(mock_hardware))
        end
        
        it 'should flash' do
          flash[:notice].should =~ /already associated/
        end
      end
    end
  end
end
