class ManufacturersController < ApplicationController
  layout 'museum'

  def index
    @manufacturers = Manufacturer.ordered
  end

  def show
    @manufacturer = Manufacturer.find(params[:id])
    session[:return_to] = {
      :name => @manufacturer.name,
      :url => request.request_uri
    }
  end

end
