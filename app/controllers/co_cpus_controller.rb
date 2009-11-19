class CoCpusController < ApplicationController
  layout 'museum'
  def index
    @co_cpus = CoCpu.ordered
  end

  def show
    @co_cpu = CoCpu.find(params[:id])
  end

end
