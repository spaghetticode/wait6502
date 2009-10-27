class Admin::PeripheralTypesController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @peripheral_types = PeripheralType.ordered
  end
  
  def new
    @peripheral_type = PeripheralType.new
  end
  
  def create
    @peripheral_type = PeripheralType.new(params[:peripheral_type])
    if @peripheral_type.save
      flash[:notice] = 'Peripheral type was successfully created.'
      redirect_to admin_peripheral_types_path
    else
      render :action => 'new'
    end
  end
  
  def destroy
    if Peripheral.find_by_peripheral_type_id(params[:id]).nil?
      PeripheralType.find(params[:id]).destroy
      flash[:notice] = 'Peripheral type was successfully destroyed.'
    else
      flash[:error] = 'Can\'t destroy: peripheral type still has associated peripherals.'
    end
    redirect_to admin_peripheral_types_path
  end
end
