module Admin::ResultsetsHelper
  def auction_link(item)
    url = item.view_item_url_for_natural_search
    link_to item.title, url, :onclick => "window.open('#{url}');return false;"
  end
end