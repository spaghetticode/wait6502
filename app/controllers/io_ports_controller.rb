class IoPortsController < ApplicationController
  layout 'museum'
  
  def index
    @io_ports = IoPort.ordered
  end

  def show
    @io_port = IoPort.find(params[:id])
  end
end
