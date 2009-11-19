class OperativeSystemsController < ApplicationController
  layout 'museum'
  
  def index
    @operative_systems = OperativeSystem.ordered
  end

  def show
    @operative_system = OperativeSystem.find(params[:id])
  end
end
