class PeripheralsController < ApplicationController
  layout 'default'
  
  def index
    @peripherals = Hardware.peripheral.ordered
  end

  def show
    @peripheral = Hardware.find(params[:id])
  end

end
