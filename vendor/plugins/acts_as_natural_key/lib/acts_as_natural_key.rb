module ActsAsNaturalKey
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def acts_as_natural_key(field)
      set_primary_key field
      named_scope :ordered, :order => field.to_s
      validates_presence_of field
      validates_uniqueness_of field, :case_sensitive => false
    end
  end
  
  def initialize(fields={})
    super
    fields.each do |field, value|
      self[field] = value
    end
  end
end
    
    