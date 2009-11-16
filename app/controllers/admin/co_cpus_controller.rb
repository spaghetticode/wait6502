class Admin::CoCpusController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    conditions = [CoCpu.concat_query, "%#{params[:keywords]}%"] unless params[:keywords].blank?
    @co_cpus = CoCpu.paginate(
      :page => params[:page],
      :conditions => conditions,
      :order => "#{params[:order] || 'co_cpu_name_id'} #{params[:desc]}",
      :include => :manufacturer
    )
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
    if co_cpu.hardware.empty?
      co_cpu.destroy
      flash[:notice] = 'Co-CPU was successfully destroyed.'
    else
      flash[:error] = 'Can\'t destroy: co-CPU still has some hardware associated.'
    end
    redirect_to(admin_co_cpus_path)
  end
end
