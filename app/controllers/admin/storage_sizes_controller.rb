class Admin::StorageSizesController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @storage_sizes = StorageSize.ordered
  end

  def new
    @storage_size = StorageSize.new

  end

  def create
    @storage_size = StorageSize.new(params[:storage_size])
    if @storage_size.save
      flash[:notice] = 'Storage size was successfully created.'
      redirect_to(admin_storage_sizes_path)
    else
      render :action => "new"
    end
  end

  def delete
    if BuiltinStorage.find_by_storage_size_id(params[:id]).nil?
      StorageSize.find(params[:id]).destroy
      flash[:notice] = 'Storage size was successfully destroyed.'
    else
      flash[:error] = 'Can\'t destroy: storage size is part of a builtin storage'
    end
    redirect_to admin_storage_sizes_path
  end
end
