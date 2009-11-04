ebay_config = File.dirname(__FILE__) + '/../../../config/config_ebay.yml'
cp File.dirname(__FILE__) + 'config_ebay.yml.tpl' ebay_config unless File.file?(ebay_config)
puts 'Created blank ebay config file'