# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def hardware_type_selector(f)
    f.select :hardware_type_id, HardwareType.ordered.map(&:name), :include_blank => true
  end
  
  def builtin_language_selector(f)
    f.select :builtin_language_id, BuiltinLanguage.ordered.map(&:name), :include_blank => true
  end
  
  def country_selector(f)
    f.select :country_id, Country.ordered.map(&:name), :include_blank => true
  end
  
  def manufacturer_selector(f)
    f.select :manufacturer_id, Manufacturer.ordered.map{|m| [m.name,  m.id]}, :include_blank => true
  end
  
  def currency_selector(f)
    f.select :currency_id, Currency.ordered.map{|c| [c.code, c.id]}, :include_blank => true
  end
  
  def year_selector(field, f)
    f.select field, (1970...2010).to_a, :include_blank => true
  end
  
  def ebay_site_selector(f=nil)
    # forms where ActiveRecord objects are handled pass f, while forms that query
    # ebay apis don't, and use site_id instead of name as value parameter for the select
    if f
      f.select :ebay_site_id, EbaySite.ordered.map(&:name), :include_blank => true
    else
      select_tag :ebay_site, options_from_collection_for_select(EbaySite.ordered, :site_id, :name), :include_blank => true
    end
  end
  
  def hardware_selector(f)
    f.select :hardware_id, Hardware.ordered.map{|h| [h.name, h.id]}, :include_blank => true
  end
end
