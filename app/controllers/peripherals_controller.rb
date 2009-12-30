class PeripheralsController < ApplicationController
  layout 'museum'
  
  def index
    @peripherals = Hardware.peripheral.ordered
    session[:return_to] = {
      :name => "peripherals",
      :url => request.request_uri
    }
  end

  def show
    @peripheral = Hardware.find(params[:id])
    validate_permalink(@peripheral, :peripheral_path)
  end
end
