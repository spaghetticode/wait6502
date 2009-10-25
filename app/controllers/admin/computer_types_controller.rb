class Admin::ComputerTypesController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'

  def index
    @computer_types = ComputerType.all
  end

  def show
    @computer_type = ComputerType.find(params[:id])
  end

  def new
    @computer_type = ComputerType.new
  end

  def edit
    @computer_type = ComputerType.find(params[:id])
  end

  def create
    @computer_type = ComputerType.new(params[:computer_type])
    if @computer_type.save
      flash[:notice] = 'Computer type was successfully created.'
      redirect_to admin_computer_types_path
    else
      render :action => "new"
    end
  end

  def update
    @computer_type = ComputerType.find(params[:id])
    if @computer_type.update_attributes(params[:computer_type])
      flash[:notice] = 'Computer type was successfully updated.'
      redirect_to admin_computer_types_path
    else
      render :action => "edit"
    end
  end

  def destroy
    computer_type = ComputerType.find(params[:id])
    if computer_type.computers.empty?
      computer_type.destroy
      flash[:notice] = 'Computer type was successfully destroyed.'
    else
      flash[:error] = 'Can\'t destroy: computer type still has associated computers'
    end
    redirect_to admin_computer_types_path
  end
end
