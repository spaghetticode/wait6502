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

  def destroy
    StorageSize.find(params[:id]).destroy
    flash[:notice] = 'Storage size was successfully destroyed.'
    redirect_to admin_storage_sizes_path
  end
end
