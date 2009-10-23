class Admin::ComputersController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
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
