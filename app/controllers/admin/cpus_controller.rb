class Admin::CpusController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @cpus =Cpu.filter(params).paginate(:page => params[:page])
  end

  def new
    @cpu =Cpu.new
  end

  def edit
    @cpu =Cpu.find(params[:id])
  end

  def create
    @cpu =Cpu.new(params[:cpu])
    if @cpu.save
      flash[:notice] = 'CPU was successfully created.'
      redirect_to(admin_cpus_path)
    else
      render :action => "new"
    end
  end

  def update
    @cpu =Cpu.find(params[:id])
    if @cpu.update_attributes(params[:cpu])
      flash[:notice] = 'CPU was successfully updated.'
      redirect_to(admin_cpus_path)
    else
      render :action => "edit"
    end
  end

  def destroy
    cpu = Cpu.find(params[:id])
    if cpu.hardware.empty?
      cpu.destroy
      flash[:notice] = 'CPU was successfully destroyed.'
    else
      flash[:error] = 'Can\'t destroy: CPU still has some hardware associated.'
    end
    redirect_to admin_cpus_path    
  end
end
