class Admin::BuiltinStoragesController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @builtin_storages = BuiltinStorage.ordered.paginate(:page => params[:page])
  end

  def new
    @builtin_storage = BuiltinStorage.new
  end

  def edit
    @builtin_storage = BuiltinStorage.find(params[:id])
  end

  def create
    @builtin_storage = BuiltinStorage.new(params[:builtin_storage])
    if @builtin_storage.save
      flash[:notice] = 'Builtin storage was successfully created.'
      redirect_to(admin_builtin_storages_path)
    else
      render :action => "new"
    end
  end

  def update
    @builtin_storage = BuiltinStorage.find(params[:id])
    if @builtin_storage.update_attributes(params[:builtin_storage])
      flash[:notice] = 'Builtin storage was successfully updated.'
      redirect_to(admin_builtin_storages_path)
    else
      render :action => "edit"
    end
  end

  def destroy
    @builtin_storage = BuiltinStorage.find(params[:id])
    if @builtin_storage.hardware.empty?
      @builtin_storage.destroy
      flash[:notice] = 'Builtin storage was successfully destroyed.'
    else
      flash[:error] = 'Can\'t destroy: storage still has some hardware associated.'
    end
    redirect_to admin_builtin_storages_path
  end
end
