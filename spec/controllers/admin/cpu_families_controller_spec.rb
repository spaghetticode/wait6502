require 'spec_helper'

module CpuFamiliesControllerHelper
  def post_create
    post :create, :cpu_family => {}
  end

  def mock_cpu_family(options={})
    mock_model(CpuFamily, options)
  end
end

describe Admin::CpuFamiliesController do
  include CpuFamiliesControllerHelper
  
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

      it 'should assign @cpu_families' do
        assigns[:cpu_families].should_not be_nil
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

      it 'should assign @cpu_family' do
        assigns[:cpu_family].should_not be_nil
      end

      it 'should assign a new record to @cpu_family' do
        assigns[:cpu_family].should be_new_record
      end
    end

    describe 'POST CREATE' do
      describe 'with valid attributes' do
        before do
          CpuFamily.should_receive(:new).and_return(mock_cpu_family(:save => true))
          post_create
        end

        it 'should flash' do
          flash[:notice].should == 'CPU family was successfully created.'
        end

        it 'should redirect to admin_cpu_families_path' do
          response.should redirect_to(admin_cpu_families_path)
        end

        it 'should assign @cpu_family' do
          assigns[:cpu_family].should_not be_nil
        end
      end

      describe 'with invalid attributes' do
        before do
          CpuFamily.should_receive(:new).and_return(mock_cpu_family(:save => false))
          post_create
        end
        it 'should render new template' do
          response.should render_template(:new)
        end

        it 'should assign @cpu_family' do
          assigns[:cpu_family].should_not be_nil
        end
      end
    end

    describe 'DELETE DELETE' do
    # il classico metodo destroy è stato sostituito da questo delete che opera
    # attraverso un form che posta gli id. Tutto sto casino è per non avere negli url
    # l'id con il punto, visto che rails lo interpreta come separatore per format
      describe 'when cpu family is not used by any CPU' do        
        before do
          CpuFamily.should_receive(:find).with('68XX').and_return(mock_cpu_family(:destroy => nil))
          delete :delete, :id => '68XX'
        end

        it 'should flash' do
          flash[:notice].should == 'CPU family was successfully destroyed.'
        end

        it 'should redirect to admin_cpu_families_path' do
          response.should redirect_to(admin_cpu_families_path)
        end
      end
      
      describe 'when cpu family is used by at least one CPU' do
        before do
          Cpu.should_receive(:find_by_cpu_family_id).and_return(mock_model(Cpu))
          CpuFamily.should_not_receive(:find)
          delete :delete, :id => '68XX'
        end
        
        it 'should flash[:error]' do
          flash[:error].should_not be_nil
        end

        it 'should redirect to admin_cpu_families_path' do
          response.should redirect_to(admin_cpu_families_path)
        end
      end
    end
  end
end
