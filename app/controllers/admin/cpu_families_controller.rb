class Admin::CpuFamiliesController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @cpu_families = CpuFamily.ordered
  end

  def new
    @cpu_family = CpuFamily.new
  end

  def create
    @cpu_family = CpuFamily.new(params[:cpu_family])
    if @cpu_family.save
      flash[:notice] = 'CPU family was successfully created.'
      redirect_to admin_cpu_families_path
    else
      render :action => "new"
    end
  end

  def delete
    if Cpu.find_by_cpu_family_id(params[:id]).nil?
      CpuFamily.find(params[:id]).destroy
      flash[:notice] = 'CPU family was successfully destroyed.'
    else
      flash[:error] = 'Can\'t destroy: CPU family is part of CPU'
    end
    redirect_to admin_cpu_families_path
  end
end
