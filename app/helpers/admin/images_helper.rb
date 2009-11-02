module Admin::ImagesHelper
  
  def edit_admin_imageable_image_path(imageable, image)
    send("edit_admin_#{model_for(imageable)}_image_path", imageable, image)
  end
  
  def admin_imageable_image_path(imageable, image)
    send("admin_#{model_for(imageable)}_image_path", imageable, image)
  end
  
  def admin_imageable_images_path(imageable)
    send("admin_#{model_for(imageable)}_images_path", imageable)
  end
  
  def new_admin_imageable_image_path(imageable)
    send("new_admin_#{model_for(imageable)}_image_path", imageable)
  end
  
  def edit_admin_imageable_path(imageable)
    send("edit_admin_#{model_for(imageable)}_path", imageable)
  end
  
  def model_for(imageable)
    imageable.class.to_s.downcase
  end
end
