class Admin::ComputersController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  %w{cpu builtin_storage operative_system co_cpu io_port}.each do |model|
    model_name = model.capitalize.gsub('_', ' ')
    
    define_method "add_#{model}" do
      model_id = params["#{model}_id"]
      @computer = Computer.find(params[:id])
      unless @computer.send(model.pluralize).find_by_id(model_id)
        @model = model.classify.constantize.find(model_id)
        @computer.send(model.pluralize) << @model
        flash[:notice] = "#{model_name} was successfully added."
      else
        flash[:notice] = "#{model_name} is already associated."
      end
      redirect_to edit_admin_computer_path(@computer)
    end
    
    define_method "remove_#{model}" do
      @computer = Computer.find(params[:id])
      @model = model.classify.constantize.find(params["#{model}_id"])
      @computer.send(model.pluralize).delete(@model)
      flash[:notice] = "#{model_name} was successfully removed."
      redirect_to edit_admin_computer_path(@computer)
    end
  end
  
  def index
    @computers = Computer.ordered.paginate(:page => params[:page])
  end


  def new
    @computer = Computer.new
  end

  def edit
    @computer = Computer.find(params[:id])
  end

  def create
    @computer = Computer.new(params[:computer])
    if @computer.save
      flash[:notice] = 'Computer was successfully created.'
      redirect_to(edit_admin_computer_path(@computer))
    else
      render :action => "new"
    end
  end

  def update
    @computer = Computer.find(params[:id])
    if @computer.update_attributes(params[:computer])
      flash[:notice] = 'Computer was successfully updated.'
      redirect_to(edit_admin_computer_path(@computer))
    else
      render :action => "edit"
    end
  end  
  
  def destroy
    Computer.find(params[:id]).destroy
    flash[:notice] = 'Computer was successfully destroyed.'
    redirect_to admin_computers_path
  end
end
