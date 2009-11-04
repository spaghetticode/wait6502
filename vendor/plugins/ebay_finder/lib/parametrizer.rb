class String
  def ebay_camelize
    self.camelize.downcase_first_letter
  end
  
  def downcase_first_letter
    returning self.dup do |string|
      string[0] = string.at(0).downcase unless string.empty?
    end
  end
end

class Symbol
  def ebay_camelize
    self.to_s.ebay_camelize
  end
end

class Hash
  def ebay_parametrize(parent=nil)
    inject([]) do |collection, couple|
      name, value = couple
      if value.is_a? Hash
        collection << "#{self[name].ebay_parametrize(name)}"
      else
        prefix = parent ? "#{parent.ebay_camelize}." : ''
        collection << "#{prefix}#{name.ebay_camelize}=#{CGI.escape(value.to_s).gsub('+', '%20')}"
      end
    end.join("&")
  end
end