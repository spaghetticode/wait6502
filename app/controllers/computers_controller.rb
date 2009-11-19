class ComputersController < ApplicationController
  layout 'museum'
  
  def index
    flash[:error].now = 'You must choose a letter' unless params[:letter]
    @computers = Hardware.computer.by_manufacturer.find_by_initial(params[:letter])
  end

  def show
    @computer = Hardware.find(params[:id])
  end
end
