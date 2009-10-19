require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::IoPortsController do

  def mock_io_port(stubs={})
    @mock_io_port ||= mock_model(IoPort, stubs)
  end
  describe 'BEING AUTHENTICATED' do
    before do
      activate_authlogic
      UserSession.create!(Factory(:user))
    end
    
    describe "GET index" do
      it "assigns all admin_io_ports as @admin_io_ports" do
        IoPort.stub!(:find).with(:all).and_return([mock_io_port])
        get :index
        assigns[:io_ports].should == [mock_io_port]
      end
    end

    describe "GET new" do
      it "assigns a new io_port as @io_port" do
        IoPort.stub!(:new).and_return(mock_io_port)
        get :new
        assigns[:io_port].should equal(mock_io_port)
      end
    end

    describe "GET edit" do
      it "assigns the requested io_port as @io_port" do
        IoPort.stub!(:find).with("37").and_return(mock_io_port)
        get :edit, :id => "37"
        assigns[:io_port].should equal(mock_io_port)
      end
    end

    describe "POST create" do

      describe "with valid params" do
        it "assigns a newly created io_port as @io_port" do
          IoPort.stub!(:new).with({'these' => 'params'}).and_return(mock_io_port(:save => true))
          post :create, :io_port => {:these => 'params'}
          assigns[:io_port].should equal(mock_io_port)
        end

        it "redirects to the created io_port" do
          IoPort.stub!(:new).and_return(mock_io_port(:save => true))
          post :create, :io_port => {}
          response.should redirect_to(admin_io_ports_path)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved io_port as @io_port" do
          IoPort.stub!(:new).with({'these' => 'params'}).and_return(mock_io_port(:save => false))
          post :create, :io_port => {:these => 'params'}
          assigns[:io_port].should equal(mock_io_port)
        end

        it "re-renders the 'new' template" do
          IoPort.stub!(:new).and_return(mock_io_port(:save => false))
          post :create, :io_port => {}
          response.should render_template('new')
        end
      end

    end

    describe "PUT update" do

      describe "with valid params" do
        it "updates the requested io_port" do
          IoPort.should_receive(:find).with("37").and_return(mock_io_port)
          mock_io_port.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :io_port => {:these => 'params'}
        end

        it "assigns the requested io_port as @io_port" do
          IoPort.stub!(:find).and_return(mock_io_port(:update_attributes => true))
          put :update, :id => "1"
          assigns[:io_port].should equal(mock_io_port)
        end

        it "redirects to the io_port" do
          IoPort.stub!(:find).and_return(mock_io_port(:update_attributes => true))
          put :update, :id => "1"
          response.should redirect_to(admin_io_ports_path)
        end
      end

      describe "with invalid params" do
        it "updates the requested io_port" do
          IoPort.should_receive(:find).with("37").and_return(mock_io_port)
          mock_io_port.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :io_port => {:these => 'params'}
        end

        it "assigns the io_port as @io_port" do
          IoPort.stub!(:find).and_return(mock_io_port(:update_attributes => false))
          put :update, :id => "1"
          assigns[:io_port].should equal(mock_io_port)
        end

        it "re-renders the 'edit' template" do
          IoPort.stub!(:find).and_return(mock_io_port(:update_attributes => false))
          put :update, :id => "1"
          response.should render_template('edit')
        end
      end

    end

    describe "DELETE destroy" do
      it "destroys the requested io_port" do
        IoPort.should_receive(:find).with("37").and_return(mock_io_port)
        mock_io_port.should_receive(:destroy)
        delete :destroy, :id => "37"
      end

      it "redirects to the admin_io_ports list" do
        IoPort.stub!(:find).and_return(mock_io_port(:destroy => true))
        delete :destroy, :id => "1"
        response.should redirect_to(admin_io_ports_path)
      end
    end
  end
end
