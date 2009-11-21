class HardwareTypesController < ApplicationController
  layout 'museum'
  
  def index
    @hardware_types = HardwareType.ordered
  end

  def show
    @hardware_type = HardwareType.find(params[:id])
    session[:return_to] = {
      :name => @hardware_type.name.pluralize,
      :url => request.request_uri
    }
  end
end
