class Admin::HardwareTypesController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'

  def index
    @hardware_types = HardwareType.ordered
  end

  def show
    @hardware_type = HardwareType.find(params[:id])
  end

  def new
    @hardware_type = HardwareType.new
  end

  def edit
    @hardware_type = HardwareType.find(params[:id])
  end

  def create
    @hardware_type = HardwareType.new(params[:hardware_type])
    if @hardware_type.save
      flash[:notice] = 'Hardware type was successfully created.'
      redirect_to admin_hardware_types_path
    else
      render :action => "new"
    end
  end

  def update
    @hardware_type = HardwareType.find(params[:id])
    if @hardware_type.update_attributes(params[:hardware_type])
      flash[:notice] = 'Hardware type was successfully updated.'
      redirect_to admin_hardware_types_path
    else
      render :action => "edit"
    end
  end

  def destroy
    hardware_type = HardwareType.find(params[:id])
    if hardware_type.hardware.empty?
      hardware_type.destroy
      flash[:notice] = 'Hardware type was successfully destroyed.'
    else
      flash[:error] = 'Can\'t destroy: hardware type still has associated hardware.'
    end
    redirect_to admin_hardware_types_path
  end
end
