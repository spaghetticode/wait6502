class CoCpusController < ApplicationController
  layout 'museum'
  def index
    @co_cpus = CoCpu.ordered
  end

  def show
    @co_cpu = CoCpu.find(params[:id])
    session[:return_to] = {
      :name => @co_cpu.name,
      :url => request.request_uri
    }
  end
end
