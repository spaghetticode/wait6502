class Admin::IoPortsController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @io_ports = IoPort.all
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
    IoPort.find(params[:id]).destroy
    flash[:notice] = 'IO Port was successfully destroyed.'
    redirect_to admin_io_ports_path

  end
end
