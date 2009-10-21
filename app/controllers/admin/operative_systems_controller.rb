class Admin::OperativeSystemsController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @operative_systems = OperativeSystem.ordered.paginate(:page => params[:page])
  end
  
  def new
    @operative_system = OperativeSystem.new
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
  
  def delete
    OperativeSystem.find(params[:id]).destroy
    flash[:notice] = 'Operative system was successfully destroyed.'
    redirect_to admin_operative_systems_path
  end
end
