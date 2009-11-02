class Admin::ImagesController < ApplicationController
  include Admin::ImagesHelper
  before_filter :require_logged_in, :find_imageable
  layout 'admin'
  
  def index
    @images = @imageable.images
  end

  def new
    @image = Image.new
  end

  def edit
    @image = Image.find(params[:id])
  end

  def create
    @image = @imageable.images.build(params[:image])
    if @image.save
      flash[:notice] = 'Image was successfully created.'
      redirect_to admin_imageable_images_path(@imageable)
    else
      render :action => "new"
    end
  end

  def update
    @image = Image.find(params[:id])
    if @image.update_attributes(params[:image])
      flash[:notice] = 'Image was successfully updated.'
      redirect_to admin_imageable_images_path(@imageable)
    else
      render :action => "edit"
    end
  end

  def destroy
    @imageable.images.destroy(params[:id])
    flash[:notice] = 'Image was successfully destroyed.'
    redirect_to admin_imageable_images_path(@imageable)
  end
  
  private
  
  def find_imageable
    params.each_pair do |parameter, value|
      if parameter =~/(\w+)_id$/
        @imageable = $1.classify.constantize.find(value)
      end
    end
  end
end

