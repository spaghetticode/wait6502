class CpusController < ApplicationController
  layout 'museum'
  
  def index
    @cpus = Cpu.ordered.all(:group => 'manufacturer_id, cpu_name_id')
  end

  def show
    @cpu = Cpu.find(params[:id])
  end

end
