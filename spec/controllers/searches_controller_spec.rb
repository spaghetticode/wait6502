require 'spec_helper'

describe SearchesController do
  
  it 'should not raise a RedirectBackError' do
    lambda do
      get :create
    end.should_not raise_error(ActionController::RedirectBackError)
  end

end
