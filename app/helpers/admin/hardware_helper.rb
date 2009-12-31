module Admin::HardwareHelper
  def hardware_category(category)
    category.blank? && category = 'Hardware'
    category.pluralize.capitalize
  end
  
  def price_for(price)
    format = price.amount.ceil.to_f == price.amount ? '%.0f' : '%.2f'
    "#{price.currency_id} #{format}" % price.amount
  end   
end