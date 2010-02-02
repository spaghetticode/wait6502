module HardwareHelper
  def specs_tr_for(title, collection, method=:name)
    content_tag :tr do
      concat content_tag(:th, title)
      concat content_tag(:td, links_from_collection(collection, method))
    end
  end
  
  def links_from_collection(collection, method=:name)
    collection.inject([]){|acc,item| acc << rest_show_link(item, method)}.join(', ')
  end
  
  def rest_show_link(model, method=:name)
    link_to model.send(method), model
  end
end
