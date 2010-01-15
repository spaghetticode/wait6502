require 'spec_helper'

describe SearchesController do

  #Delete this example and add some real ones
  it "should use SearchesController" do
    controller.should be_an_instance_of(SearchesController)
  end
  
  it 'should not raise a RedirectBackError' do
    lambda do
      get :create
    end.should_not raise_error(ActionController::RedirectBackError)
  end

end
