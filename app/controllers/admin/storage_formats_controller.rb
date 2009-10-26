class Admin::StorageFormatsController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @storage_formats = StorageFormat.ordered
  end

  def new
    @storage_format = StorageFormat.new
  end

  def create
    @storage_format = StorageFormat.new(params[:storage_format])
    if @storage_format.save
      flash[:notice] = 'Storage format was successfully created.'
      redirect_to(admin_storage_formats_path)
    else
      render :action => "new"
    end
  end

  def delete
    if BuiltinStorage.find_by_storage_format_id(params[:id]).nil?
      StorageFormat.find(params[:id]).destroy
      flash[:notice] = 'Storage format was successfully destroyed.'
    else
      flash[:error] = 'Can\'t destroy: storage format is part of a builtin storage'
    end
    redirect_to admin_storage_formats_path
  end
end
