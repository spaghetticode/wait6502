class Resultset
  attr_accessor :keywords, :ebay_site, :items, :total_pages, :max_entries, :page_number, :total_items
  
  def initialize(params={})
    set_request_params(params)
    set_results
  end
  
  private
  
  def set_results
    response     = get_ebay_response
    @items       = response.items
    @total_items = response.total_items
    @total_pages = response.total_pages
  end
  
  def set_request_params(params)
    params.each do |method, value|
      if respond_to?("#{method}=")
        self.send "#{method}=", value
      end
    end
    @ebay_site = params[:ebay_site_id]
    @max_entries ||= 100
    @page_number ||= 1
  end
  
  def get_ebay_response
    EbayFinder::Request.new(
      :query_keywords => keywords,
      :website        => ebay_site,
      :page_number    => page_number,
      :max_entries    => max_entries
    ).response
  end
end