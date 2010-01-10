class Admin::CoCpuTypesController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @co_cpu_types = CoCpuType.all
  end

  def new
    @co_cpu_type = CoCpuType.new
  end

  def create
    @co_cpu_type = CoCpuType.new(params[:co_cpu_type])
    if @co_cpu_type.save
      flash[:notice] = 'Co-CPU type was successfully created.'
      redirect_to admin_co_cpu_types_path
    else
      render :action => "new"
    end
  end

  def delete
    if CoCpu.find_by_co_cpu_type_id(params[:id]).nil?
      CoCpuType.find(params[:id]).destroy
      flash[:notice] = 'Co-CPU type was successfully destroyed.'
    else
      flash[:error] = 'Can\'t destroy: co-CPU type is still used by co-CPU.'
    end
    redirect_to admin_co_cpu_types_path
  end
end
