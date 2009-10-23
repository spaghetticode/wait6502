class Admin::OperativeSystemsController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @operative_systems = OperativeSystem.ordered.paginate(:page => params[:page])
  end
  
  def new
    @operative_system = OperativeSystem.new
  end
  
  def edit
    @operative_system = OperativeSystem.find(params[:id])
  end
  
  def create
    @operative_system = OperativeSystem.new(params[:operative_system])
    if @operative_system.save
      flash[:notice] = 'Operative system was successfully created.'
      redirect_to admin_operative_systems_path
    else
      render :action => "new"
    end
  end
  
  def update
    @operative_system = OperativeSystem.find(params[:id])
    if @operative_system.update_attributes(params[:operative_system])
      flash[:notice] = 'Operative system was successfully updated.'
      redirect_to admin_operative_systems_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    OperativeSystem.find(params[:id]).destroy
    flash[:notice] = 'Operative system was successfully destroyed.'
    redirect_to admin_operative_systems_path
  end
end
