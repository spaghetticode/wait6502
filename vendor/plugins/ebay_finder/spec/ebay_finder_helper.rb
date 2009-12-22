module EbayFinderHelper
   def ebay_app_id_from_config
    hash = YAML.load_file("#{RAILS_ROOT}/config/ebay_config.yml")
    hash[RAILS_ENV.to_sym][:app_id]
  end
  
  def xml_response_from_file(filename, klass=EbayFinder::FindItemsAdvancedResponse)
    klass.new(File.read(File.dirname(__FILE__) + "/stubs/#{filename}"))
  end  
end