class String
  def permalink
    string = self.dup.downcase.strip
    string.gsub_accented_vowels
    string.gsub_ampersand
    string.gsub_invalid_chars
  end
  
  def gsub_accented_vowels
    {'è' => 'e', 'é' => 'e', 'ì' => 'i', 'ò' => 'o', 'à' => 'a', 'ù' => 'u'}.each do |accented, plain|
      self.gsub!(accented, plain)
    end
    self
  end
  
  def gsub_ampersand
    gsub!('&', 'and')
    self
  end
  
  
  def gsub_invalid_chars
    gsub(/[\s\-\/]+/, '_').gsub(/[\W€£]/, '').gsub(/_+/, '-')
  end
end

module PermalinkField
  def permalink_field(field)
    alias to_param_orig to_param
    define_method :to_param do
      [id, self.send(field).permalink].join('-')
    end
  end
end