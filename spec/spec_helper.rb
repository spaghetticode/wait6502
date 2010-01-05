# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.dirname(__FILE__) + "/../config/environment" unless defined?(RAILS_ROOT)
require 'spec/autorun'
require 'spec/rails'
require 'authlogic/test_case'
require File.dirname(__FILE__) + '/factories'
require File.dirname(__FILE__) + '/controller_macros'
require File.dirname(__FILE__) + '/model_macros'

# removing constants to be redefined:
Image.class_eval{remove_const :FS_PREFIX}
Auction.class_eval{remove_const :GALLERY_IMAGES_PATH}
Country.class_eval{remove_const :FS_PATH}

# changing the location for saved auction gallery image files:
Auction::GALLERY_IMAGES_PATH = "#{RAILS_ROOT}/spec/fixtures/images/auctions"
# changing location where image files will be saved
Image::FS_PREFIX = File.join(RAILS_ROOT, 'spec/fixtures', Image::DB_PREFIX)
# changing location where countries flag images will be saved
Country::FS_PATH = File.join(RAILS_ROOT, 'spec/fixtures')

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Spec::Runner.configure do |config|
  config.include ControllerMacros
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
end
