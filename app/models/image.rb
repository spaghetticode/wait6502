class Image < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
  
  
  has_attached_file :picture,
    :styles => { :thumb => 'x50', :small => 'x150', :normal => '600x' },
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
    :path => ':class/:id/:style.:extension'
    
  validates_presence_of :imageable_id, :imageable_type
  validates_attachment_presence :picture
  validates_attachment_content_type :picture, :content_type => /image\/.{3,4}/
  
  def title
    self[:title].blank? ? imageable.name : self[:title]
  end
end
