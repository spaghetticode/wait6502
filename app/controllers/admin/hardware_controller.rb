class Admin::HardwareController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  %w{cpu builtin_storage operative_system co_cpu io_port}.each do |model|
    model_name = model.capitalize.gsub('_', ' ')
    
    define_method "add_#{model}" do
      model_id = params["#{model}_id"]
      @hardware = Hardware.find(params[:id])
      unless @hardware.send(model.pluralize).find_by_id(model_id)
        @model = model.classify.constantize.find(model_id)
        @hardware.send(model.pluralize) << @model
        flash[:notice] = "#{model_name} was successfully added."
      else
        flash[:notice] = "#{model_name} is already associated."
      end
      redirect_to edit_admin_hardware_path(@hardware)
    end
    
    define_method "remove_#{model}" do
      @hardware = Hardware.find(params[:id])
      @model = model.classify.constantize.find(params["#{model}_id"])
      @hardware.send(model.pluralize).delete(@model)
      flash[:notice] = "#{model_name} was successfully removed."
      redirect_to edit_admin_hardware_path(@hardware)
    end
  end
  
  def index
    @hardware = Hardware.ordered.paginate(:page => params[:page])
  end


  def new
    @hardware = Hardware.new
  end

  def edit
    @hardware = Hardware.find(params[:id])
  end

  def create
    @hardware = Hardware.new(params[:hardware])
    if @hardware.save
      flash[:notice] = 'Hardware was successfully created.'
      redirect_to(edit_admin_hardware_path(@hardware))
    else
      render :action => "new"
    end
  end

  def update
    @hardware = Hardware.find(params[:id])
    if @hardware.update_attributes(params[:hardware])
      flash[:notice] = 'Hardware was successfully updated.'
      redirect_to(edit_admin_hardware_path(@hardware))
    else
      render :action => "edit"
    end
  end  
  
  def destroy
    Hardware.find(params[:id]).destroy
    flash[:notice] = 'Hardware was successfully destroyed.'
    redirect_to admin_hardware_index_path
  end
end
