module Admin::ImagesHelper
  
  def edit_admin_imageable_image_path(imageable, image)
    model = imageable.class.to_s.downcase
    send("edit_admin_#{model}_image_path", imageable, image)
  end
  
  def admin_imageable_image_path(imageable, image)
    model = imageable.class.to_s.downcase
    send("admin_#{model}_image_path", imageable, image)
  end
  
  def admin_imageable_images_path(imageable)
    model = imageable.class.to_s.downcase
    send("admin_#{model}_images_path", imageable)
  end
  
  def new_admin_imageable_image_path(imageable)
    model = imageable.class.to_s.downcase
    send("new_admin_#{model}_image_path", imageable)
  end
end
