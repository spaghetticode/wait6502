require 'spec_helper'

describe Admin::ImagesController do
  def mock_image(options={})
    @mock ||= mock_model(Image, options)
  end
  
  def imageable(options={})
    images = []
    images.stub!(:build => mock_image)
    @imageable ||= mock_model(Hardware, options.merge(:images => images, :class_name => 'Hardware'))
  end
  
  describe 'without being authenticated' do
    should_flash_and_redirect_for(
      {
      :index => :get,
      :new => :get,
      :edit => :get,
      :create => :post,
      :update => :put,
      :destroy => :delete
      },
      :hardware_id => '1'
    )
  end
  
  describe 'being authenticated' do
    before do
      activate_authlogic
      UserSession.create!(Factory(:user))
      Hardware.should_receive(:find).with('1').and_return(imageable)
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
      
      it 'should assign @images' do
        assigns[:images].should_not be_nil
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
      
      it 'should assign @image' do
        assigns[:image].should_not be_nil
      end
    end
    
    describe 'GET EDIT' do
      before do
        Image.should_receive(:find).with('2').and_return(mock_image)
        get :edit, :id => '2', :hardware_id => '1'
      end
      
      it 'should be success' do
        response.should be_success
      end
      
      it 'should assign @image' do
        assigns[:image].should_not be_nil
      end
      
      it 'should render edit template' do
        response.should render_template(:edit)
      end
    end
    
    describe 'POST CREATE' do
      describe 'with valid attributes' do
        before do
          mock_image.should_receive(:save).and_return(:true)
          post :create, :hardware_id => '1', :image => {}
        end
        
        it 'should redirect to associated imageable images page' do
          response.should redirect_to(admin_hardware_images_path(imageable))
        end
        
        it 'should flash' do
          flash[:notice].should == 'Image was successfully created.'
        end
        
        it 'should assign @image' do
          assigns[:image].should_not be_nil
        end
      end
      
      describe 'with invalid attributes' do
        before do
          mock_image.should_receive(:save).and_return(false)
          post :create, :hardware_id => '1', :image => {}
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
        
        it 'should assign @image' do
          assigns[:image].should_not be_nil
        end
      end
      
      describe 'PUT UPDATE' do
        before do
          Image.should_receive(:find).and_return(mock_image)
        end
        
        describe 'with valid attributes' do
          before do
            mock_image.should_receive(:update_attributes).and_return(true)
            put :update, :id => '2', :hardware_id => '1', :image => {}
          end
          
          it 'should redirect to associated imageable images page' do
            response.should redirect_to(admin_hardware_images_path(imageable))
          end
          
          it 'should flash' do
            flash[:notice].should == 'Image was successfully updated.'
          end
          
          it 'should assign @image' do
            assigns[:image].should_not be_nil
          end
        end
        
        describe 'with invalid attributes' do
          before do
            mock_image.should_receive(:update_attributes).and_return(false)
            put :update, :id => '2', :hardware_id => '1', :image => {}
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
          
          it 'should assign @image' do
            assigns[:image].should_not be_nil
          end
        end
      end
      
      describe 'DELETE DESTROY' do
        before do
          imageable.images.should_receive(:destroy)
          delete :destroy, :id => '1', :hardware_id => '1'
        end
        
        it 'should redirect to associated imageable images page' do
          response.should redirect_to(admin_hardware_images_path(imageable))
        end
        
        it 'should flash' do
          flash[:notice].should == 'Image was successfully destroyed.'
        end
      end
    end
  end
end
