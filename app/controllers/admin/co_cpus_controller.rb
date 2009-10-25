class Admin::CoCpusController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @co_cpus = CoCpu.all
  end

  def new
    @co_cpu = CoCpu.new
  end

  def edit
    @co_cpu = CoCpu.find(params[:id])
  end

  def create
    @co_cpu = CoCpu.new(params[:co_cpu])
    if @co_cpu.save
      flash[:notice] = 'Co CPU was successfully created.'
      redirect_to( admin_co_cpus_path)
    else
      render :action => "new"
    end
  end

  def update
    @co_cpu = CoCpu.find(params[:id])
    if @co_cpu.update_attributes(params[:co_cpu])
      flash[:notice] = 'Co-CPU was successfully updated.'
      redirect_to(admin_co_cpus_path)
    else
      render :action => "edit"
    end
  end

  def destroy
    co_cpu = CoCpu.find(params[:id])
    if co_cpu.computers.empty?
      co_cpu.destroy
      flash[:notice] = 'Co-CPU was successfully destroyed.'
    else
      flash[:error] = 'Can\'t destroy: co-CPU still has associated computers'
    end
    redirect_to(admin_co_cpus_path)
  end
end
