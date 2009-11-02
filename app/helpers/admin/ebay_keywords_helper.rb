module Admin::EbayKeywordsHelper
  
  def admin_searchable_ebay_keyword_path(searchable, kw)
    send("admin_#{model_for(searchable)}_ebay_keyword_path", searchable, kw)
  end
  
  def admin_searchable_ebay_keywords_path(searchable)
    send("admin_#{model_for(searchable)}_ebay_keywords_path", searchable)
  end
  
  def new_admin_searchable_ebay_keyword_path(searchable)
    send("new_admin_#{model_for(searchable)}_ebay_keyword_path", searchable)
  end
  
  def edit_admin_searchable_path(searchable)
    send("edit_admin_#{model_for(searchable)}_path", searchable)
  end
  
  def model_for(searchable)
    searchable.class.to_s.downcase
  end
end
