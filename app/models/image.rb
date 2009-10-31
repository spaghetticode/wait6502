class Image < ActiveRecord::Base
  attr_accessor :uploaded_file
  
  validates_presence_of :original_filename, :uploaded_file
  
end
