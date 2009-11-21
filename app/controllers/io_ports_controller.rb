class IoPortsController < ApplicationController
  layout 'museum'
  
  def index
    @io_ports = IoPort.ordered
  end

  def show
    @io_port = IoPort.find(params[:id])
    session[:return_to] = {
      :name => "#{@io_port.name} port",
      :url => request.request_uri
    }
  end
end
