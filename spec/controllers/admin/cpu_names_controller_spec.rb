require 'spec_helper'

module CpuNamesControllerHelper
  def post_create
    post :create, :cpu_name => {}
  end

  def mock_cpu_name(options={})
    mock_model(CpuName, options)
  end
end

describe Admin::CpuNamesController do
  include CpuNamesControllerHelper
  
  describe 'WITHOUT BEING AUTHENTICATED' do
    should_flash_and_redirect_for(
      :new => :get,
      :index => :get,
      :create => :post,
      :delete => :delete
    )
  end
  
  describe 'BEING LOGGED IN' do
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

      it 'should assign @cpu_names' do
        assigns[:cpu_names].should_not be_nil
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

      it 'should assign @cpu_name' do
        assigns[:cpu_name].should_not be_nil
      end

      it 'should assign a new record to @cpu_name' do
        assigns[:cpu_name].should be_new_record
      end
    end

    describe 'POST CREATE' do
      describe 'with valid attributes' do
        before do
          CpuName.should_receive(:new).and_return(mock_cpu_name(:save => true))
          post_create
        end

        it 'should flash' do
          flash[:notice].should == 'CPU name was successfully created.'
        end

        it 'should redirect to admin_cpu_names_path' do
          response.should redirect_to(admin_cpu_names_path)
        end

        it 'should assign @cpu_name' do
          assigns[:cpu_name].should_not be_nil
        end
      end

      describe 'with invalid attributes' do
        before do
          CpuName.should_receive(:new).and_return(mock_cpu_name(:save => false))
          post_create
        end
        it 'should render new template' do
          response.should render_template(:new)
        end

        it 'should assign @cpu_name' do
          assigns[:cpu_name].should_not be_nil
        end
      end
    end

    describe 'DELETE DELETE' do
    # il classico metodo destroy è stato sostituito da questo delete che opera
    # attraverso un form che posta gli id. Tutto sto casino è per non avere negli url
    # l'id con il punto, visto che rails lo interpreta come separatore per format
    
      before do
        CpuName.should_receive(:find).with('6502').and_return(mock_cpu_name(:destroy => nil))
        delete :delete, :id => '6502'
      end

      it 'should flash' do
        flash[:notice].should == 'CPU name was successfully destroyed.'
      end

      it 'should redirect to admin_cpu_names_path' do
        response.should redirect_to(admin_cpu_names_path)
      end
    end
  end
end
