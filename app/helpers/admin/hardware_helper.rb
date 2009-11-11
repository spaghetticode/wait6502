module Admin::HardwareHelper
  def hardware_category(category)
    category.blank? && category = 'Hardware'
    category.pluralize.capitalize
  end
end