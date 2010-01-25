class CpusController < ApplicationController
  layout 'museum'
  
  def index
    @cpus = Cpu.main.ordered
  end

  def show
    @cpu = Cpu.find(params[:id])
    session[:return_to] = {
      :name => @cpu.name,
      :url => request.request_uri
    }
  end
end
