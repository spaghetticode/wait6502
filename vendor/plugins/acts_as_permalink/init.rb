require File.dirname(__FILE__) + '/lib/acts_as_permalink'

ActiveRecord::Base.class_eval do
  extend ActsAs::Permalink
end