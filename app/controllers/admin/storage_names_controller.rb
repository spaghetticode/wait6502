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
    if BuiltinStorage.find_by_storage_name_id(params[:id]).nil?
      StorageName.find(params[:id]).destroy
      flash[:notice] = 'Storage name was successfully destroyed.'
    else
      flash[:error] = 'Can\'t destroy: storage name is part of a builtin storage'
    end
    redirect_to admin_storage_names_path
  end
end
