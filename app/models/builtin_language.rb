class BuiltinLanguage < ActiveRecord::Base
  include ActsAsNaturalKey
  acts_as_natural_key :name
  
  has_many :hardware
  
  before_save :set_permalink
  
  private
  
  def set_permalink
    # as name is unique, there are good chances that also
    # permalink will be unique, as we won't probably see a 
    # language which includes the _DOT_ string in its name
    self.permalink = CGI.escape(name).gsub('.', '_DOT_')
  end
end
