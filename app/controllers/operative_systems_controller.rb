class OperativeSystemsController < ApplicationController
  layout 'museum'
  
  def index
    @operative_systems = OperativeSystem.ordered
  end

  def show
    @operative_system = OperativeSystem.find(params[:id])
    session[:return_to] = {
      :name => @operative_system.name,
      :url => request.request_uri
    } 
  end
end
