class PeripheralsController < ApplicationController
  layout 'museum'
  
  def index
    @peripherals = Hardware.peripheral.ordered
  end

  def show
    @peripheral = Hardware.find(params[:id])
  end

end
