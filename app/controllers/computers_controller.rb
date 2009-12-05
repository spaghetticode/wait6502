class ComputersController < ApplicationController
  layout 'museum'
  
  def index
    letter = params[:letter]
    flash.now[:error] = 'You must choose a letter' unless letter
    @computers = Hardware.computer.by_manufacturer.filter_initial(letter)
    session[:return_to] = {
      :name => "#{letter}-computers",
      :url => request.request_uri
    } 
  end

  def show
    @computer = Hardware.find(params[:id])
  end
end
