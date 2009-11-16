class Admin::ManufacturersController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    conditions = [Manufacturer.concat_query, "%#{params[:keywords]}%"] if params[:keywords]
    @manufacturers = Manufacturer.paginate(
      :page => params[:page],
      :conditions => conditions, 
      :order => "#{params[:order] || 'manufacturers.name'} #{params[:desc]}",
      :include => :country
    )
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
      redirect_to admin_manufacturers_path
    else
      render :action => "new"
    end
  end

  def update
    @manufacturer = Manufacturer.find(params[:id])
    if @manufacturer.update_attributes(params[:manufacturer])
      flash[:notice] = 'Manufacturer was successfully updated.'
      redirect_to admin_manufacturers_path
    else
      render :action => "edit"
    end
  end

  def destroy
    manufacturer = Manufacturer.find(params[:id])
    if manufacturer.cpus.empty? && manufacturer.co_cpus.empty? && manufacturer.hardware.empty?
      manufacturer.destroy
      flash[:notice] = 'Manufacturer was successfully destroyed.'
    else
      flash[:error] = 'Can\'t destroy: manufacturer still has some record associated.'
    end
    redirect_to admin_manufacturers_path
  end
end
