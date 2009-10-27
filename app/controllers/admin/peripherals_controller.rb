class Admin::PeripheralsController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @peripherals = Peripheral.ordered.paginate(:page => params[:page])
  end
  
  def new
    @peripheral = Peripheral.new
  end

  def edit
    @peripheral = Peripheral.find(params[:id])
  end

  def create
    @peripheral = Peripheral.new(params[:peripheral])
    if @peripheral.save
      flash[:notice] = 'Peripheral was successfully created.'
      redirect_to edit_admin_peripheral_path(@peripheral)
    else
      render :action => "new"
    end
  end

  def update
    @peripheral = Peripheral.find(params[:id])
    if @peripheral.update_attributes(params[:peripheral])
      flash[:notice] = 'Peripheral was successfully updated.'
      redirect_to edit_admin_peripheral_path(@peripheral)
    else
      render :action => "edit"
    end
  end

  def destroy
    Peripheral.find(params[:id]).destroy
    flash[:notice] = 'Peripheral was successfully destroyed.'
    redirect_to admin_peripherals_path
  end
end
