class Admin::StorageNamesController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @storage_names = StorageName.ordered
  end

  def new
    @storage_name = StorageName.new
  end

  def create
    @storage_name = StorageName.new(params[:storage_name])
    if @storage_name.save
      flash[:notice] = 'Storage name was successfully created.'
      redirect_to admin_storage_names_path
    else
      render :action => "new"
    end
  end

  def destroy
    StorageName.find(params[:id]).destroy
    flash[:notice] = 'Storage name was successfully destroyed.'
    redirect_to admin_storage_names_path
  end
end
