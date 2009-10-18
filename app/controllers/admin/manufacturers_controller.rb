class Admin::ManufacturersController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @manufacturers = Manufacturer.ordered.paginate(:page => params[:page])
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def edit
    @manufacturer = Manufacturer.find(params[:id])
  end

  def create
    @manufacturer = Manufacturer.new(params[:manufacturer])
    if @manufacturer.save
      flash[:notice] = 'Manufacturer was successfully created.'
      redirect_to manufacturers_path
    else
      render :action => "new"
    end
  end

  def update
    @manufacturer = Manufacturer.find(params[:id])
    if @manufacturer.update_attributes(params[:manufacturer])
      flash[:notice] = 'Manufacturer was successfully updated.'
      redirect_to manufacturers_path
    else
      render :action => "edit"
    end
  end

  def destroy
    Manufacturer.find(params[:id]).destroy
    flash[:notice] = 'Manufacturer was successfully destroyed.'
    redirect_to manufacturers_path
  end
end
