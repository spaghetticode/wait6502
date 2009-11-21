class CpusController < ApplicationController
  layout 'museum'
  
  def index
    @cpus = Cpu.ordered.all(:group => 'manufacturer_id, cpu_name_id')
  end

  def show
    @cpu = Cpu.find(params[:id])
    session[:return_to] = {
      :name => @cpu.name,
      :url => request.request_uri
    }
  end
end
