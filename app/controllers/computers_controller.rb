class ComputersController < ApplicationController
  layout 'default'
  
  def index
    @computers = Hardware.computer.ordered
  end

  def show
    @computer = Hardware.find(params[:id])
  end

end
