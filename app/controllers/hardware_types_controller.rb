class HardwareTypesController < ApplicationController
  layout 'museum'
  
  def index
    @hardware_types = HardwareType.ordered
  end

  def show
    @hardware_type = HardwareType.find(params[:id])
  end

end
