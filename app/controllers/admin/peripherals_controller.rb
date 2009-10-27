class Admin::PeripheralsController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'

  
  %w{cpu builtin_storage io_port}.each do |model|
    model_name = model.capitalize.gsub('_', ' ')
    
    define_method "add_#{model}" do
      model_id = params["#{model}_id"]
      @peripheral = Peripheral.find(params[:id])
      unless @peripheral.send(model.pluralize).find_by_id(model_id)
        @model = model.classify.constantize.find(model_id)
        @peripheral.send(model.pluralize) << @model
        flash[:notice] = "#{model_name} was successfully added."
      else
        flash[:notice] = "#{model_name} is already associated."
      end
      redirect_to edit_admin_peripheral_path(@peripheral)
    end
    
    define_method "remove_#{model}" do
      @peripheral = Peripheral.find(params[:id])
      @model = model.classify.constantize.find(params["#{model}_id"])
      @peripheral.send(model.pluralize).delete(@model)
      flash[:notice] = "#{model_name} was successfully removed."
      redirect_to edit_admin_peripheral_path(@peripheral)
    end
  end
    
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
