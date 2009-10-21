class Admin::CpuNamesController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @cpu_names = CpuName.ordered.paginate(:page => params[:page])
  end

  def new
    @cpu_name = CpuName.new
  end

  def create
    @cpu_name = CpuName.new(params[:cpu_name])
      if @cpu_name.save
        flash[:notice] = 'CPU name was successfully created.'
        redirect_to admin_cpu_names_path
      else
        render :action => "new"
      end
  end
  
  def delete
    CpuName.find(params[:id]).destroy
    flash[:notice] = 'CPU name was successfully destroyed.'
    redirect_to admin_cpu_names_path
  end
end
