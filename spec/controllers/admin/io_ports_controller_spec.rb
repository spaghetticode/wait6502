require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

module IoPortsControllerHelper
  def mock_io_port(options={})
    @mock ||= mock_model(IoPort, options)
  end
  
  def put_update
    put :update, :id => '1', :io_port => {}
  end
end

describe Admin::IoPortsController do
  include IoPortsControllerHelper

  describe 'NOT BEING AUTHENTICATED' do
    should_flash_and_redirect_for(
      :new => :get,
      :show => :get,
      :edit => :get,
      :index => :get,
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
    
    describe "GET index" do
      before do
        get :index
      end
      
      it 'should be success' do
        response.should be_success
      end
      
      it 'should render index template' do
        response.should render_template(:index)
      end
      
      it 'should assign @io_ports' do
        assigns[:io_ports].should_not be_nil
      end      
    end

    describe "GET edit" do
      before do
        IoPort.should_receive(:find).and_return(mock_io_port)
        get :edit, :id => '1'
      end
      
      it 'should be success' do
        response.should be_success
      end
      
      it 'should render edit template' do
        response.should render_template(:edit)
      end
      
      it 'should assign @io_port' do
        assigns[:io_port].should_not be_nil
      end
    end

    describe "POST create" do
      describe 'with valid parameters' do
          before do
            IoPort.should_receive(:new).and_return(mock_io_port(:save => true))
            post :create, :io_port => {}
          end

          it 'should flash' do
            flash[:notice].should == 'IO Port was successfully created.'
          end

          it 'should redirect to currencies_path' do
            response.should redirect_to(admin_io_ports_path)
          end

          it 'should assign @io_port' do
            assigns[:io_port].should_not be_nil
          end
        end

      describe 'with invalid parameters' do
          before do
            IoPort.should_receive(:new).and_return(mock_io_port(:save => false))
            post :create, :io_port => {}
          end

          it 'should not flash' do
            flash[:notice].should be_nil
          end

          it 'should render new template' do
            response.should render_template(:new)
          end

          it 'should assign @io_port' do
            assigns[:io_port].should_not be_nil
          end
        end
    end

    describe 'PUT UPDATE' do
      describe 'with valid attributes' do
        before do
          IoPort.should_receive(:find).and_return(mock_io_port(:update_attributes => true))
          put_update
        end
        
        it 'should redirect to io_ports page' do
          response.should redirect_to(admin_io_ports_path)
        end
        
        it 'should flash' do
          flash[:notice].should_not be_nil
        end
        
        it 'should assign @io_port' do
          assigns[:io_port].should_not be_nil
        end
      end
      
      describe 'with invalid attributes' do
        before do
          IoPort.should_receive(:find).and_return(mock_io_port(:update_attributes => false))
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
        
        it 'should assign @io_port' do
          assigns[:io_port].should_not be_nil
        end
      end
    end
    
    describe 'DELETE DESTROY' do
      before do
        mock_io_port.should_receive(:destroy)
        IoPort.should_receive(:find).and_return(mock_io_port)
        delete :destroy, :id => '1'
      end
    
      it 'should flash' do
        flash[:notice].should == 'IO Port was successfully destroyed.'
      end
    
      it 'should redirect to io_ports_path' do
        response.should redirect_to(admin_io_ports_path)
      end
    end
  end
end
