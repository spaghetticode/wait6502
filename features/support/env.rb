# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] ||= "cucumber"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'

# Comment out the next line if you don't want Cucumber Unicode support
require 'cucumber/formatter/unicode'

# Comment out the next line if you don't want transactions to
# open/roll back around each scenario
Cucumber::Rails.use_transactional_fixtures

# Comment out the next line if you want Rails' own error handling
# (e.g. rescue_action_in_public / rescue_responses / rescue_from)
Cucumber::Rails.bypass_rescue

require 'webrat'
require 'cucumber/webrat/element_locator' # Lets you do table.diff!(element_at('#my_table_or_dl_or_ul_or_ol').to_table)

Webrat.configure do |config|
  config.mode = :rails
end

require 'cucumber/rails/rspec'
require 'webrat/core/matchers'
require 'spec/factories'
require 'spec/stubs/cucumber'

# removing constants to be redefined:
Image.send(:remove_const, :FS_PREFIX)
Auction.send(:remove_const, :GALLERY_IMAGES_PATH)

# changing location where image files will be saved:
Image::FS_PREFIX = File.join(RAILS_ROOT, 'spec/fixtures/images')
# changing the location where auction gallery image files will be saved:
Auction::GALLERY_IMAGES_PATH = "#{RAILS_ROOT}/spec/fixtures/images/auctions"

require 'pickle/world'
# Example of configuring pickle:
#
# Pickle.configure do |config|
#   config.adapters = [:machinist]
#   config.map 'I', 'myself', 'me', 'my', :to => 'user: "me"'
# end
