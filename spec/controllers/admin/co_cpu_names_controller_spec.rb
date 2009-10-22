require 'spec_helper'

module CoCpuNamesControllerHelper
  def post_create
    post :create, :co_cpu_name => {}
  end

  def mock_co_cpu_name(options={})
    mock_model(CoCpuName, options)
  end
end

describe Admin::CoCpuNamesController do
  include CoCpuNamesControllerHelper
  
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

      it 'should assign @co_cpu_names' do
        assigns[:co_cpu_names].should_not be_nil
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

      it 'should assign @co_cpu_name' do
        assigns[:co_cpu_name].should_not be_nil
      end

      it 'should assign a new record to @co_cpu_name' do
        assigns[:co_cpu_name].should be_new_record
      end
    end

    describe 'POST CREATE' do
      describe 'with valid attributes' do
        before do
          CoCpuName.should_receive(:new).and_return(mock_co_cpu_name(:save => true))
          post_create
        end

        it 'should flash' do
          flash[:notice].should == 'Co-CPU name was successfully created.'
        end

        it 'should redirect to admin_co_cpu_names_path' do
          response.should redirect_to(admin_co_cpu_names_path)
        end

        it 'should assign @co_cpu_name' do
          assigns[:co_cpu_name].should_not be_nil
        end
      end

      describe 'with invalid attributes' do
        before do
          CoCpuName.should_receive(:new).and_return(mock_co_cpu_name(:save => false))
          post_create
        end
        it 'should render new template' do
          response.should render_template(:new)
        end

        it 'should assign @co_cpu_name' do
          assigns[:co_cpu_name].should_not be_nil
        end
      end
    end

    describe 'DELETE DELETE' do
    # il classico metodo destroy è stato sostituito da questo delete che opera
    # attraverso un form che posta gli id. Tutto sto casino è per non avere negli url
    # l'id con il punto, visto che rails lo interpreta come separatore per format
    
      before do
        CoCpuName.should_receive(:find).with('Fat Agnus').and_return(mock_co_cpu_name(:destroy => nil))
        delete :delete, :id => 'Fat Agnus'
      end

      it 'should flash' do
        flash[:notice].should == 'Co-CPU name was successfully destroyed.'
      end

      it 'should redirect to admin_co_cpu_names_path' do
        response.should redirect_to(admin_co_cpu_names_path)
      end
    end
  end
end
