class Admin::IoPortsController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    conditions = [IoPort.concat_query, "%#{params[:keywords]}%"] unless params[:keywords].blank?
    @io_ports = IoPort.paginate(
      :page => params[:page],
      :conditions => conditions,
      :order => "#{params[:order] || 'name'} #{params[:desc]}"
    )
  end

  def new
    @io_port = IoPort.new
  end

  def edit
    @io_port = IoPort.find(params[:id])
  end

  def create
    @io_port = IoPort.new(params[:io_port])

    respond_to do |format|
      if @io_port.save
        flash[:notice] = 'IO Port was successfully created.'
        format.html { redirect_to(admin_io_ports_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @io_port = IoPort.find(params[:id])

    respond_to do |format|
      if @io_port.update_attributes(params[:io_port])
        flash[:notice] = 'IO Port was successfully updated.'
        format.html { redirect_to(admin_io_ports_path) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    io_port = IoPort.find(params[:id])
    if io_port.hardware.empty?
      io_port.destroy
      flash[:notice] = 'IO Port was successfully destroyed.'
    else
      flash[:error] = 'Can\'t destroy: IO port still has some hardware associated'
    end
    redirect_to admin_io_ports_path
  end
end
