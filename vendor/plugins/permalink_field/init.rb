require File.dirname(__FILE__) + '/lib/permalink_field'
class ActiveRecord::Base
  extend PermalinkField
end