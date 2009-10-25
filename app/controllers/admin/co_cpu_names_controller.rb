class Admin::CoCpuNamesController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @co_cpu_names = CoCpuName.ordered
  end

  def new
    @co_cpu_name = CoCpuName.new
  end

  def create
    @co_cpu_name = CoCpuName.new(params[:co_cpu_name])
    if @co_cpu_name.save
      flash[:notice] = 'Co-CPU name was successfully created.'
      redirect_to admin_co_cpu_names_path
    else
      render :action => "new"
    end
  end

  def delete
    if CoCpu.find_by_co_cpu_name_id(params[:id]).nil?
      CoCpuName.find(params[:id]).destroy
      flash[:notice] = 'Co-CPU name was successfully destroyed.'
    else
      flash[:error] = 'Can\'t destroy: co-CPU name is part of a co-CPU'
    end
    redirect_to admin_co_cpu_names_path
  end
end
