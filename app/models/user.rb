class User < ActiveRecord::Base
  acts_as_authentic do |user|
    user.logged_in_timeout = 45.minutes
  end
  
  named_scope :ordered, :order => 'email'
end
