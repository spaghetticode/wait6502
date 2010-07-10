class Resultset
  attr_accessor :keywords, :ebay_site, :items, :total_pages, :max_entries, :page_number, :category_id
  
  def initialize(params={})
    set_request_params(params)
  end
  
  def set_results
    response     = get_ebay_response
    @items       = response.items
    @total_pages = response.total_pages
  end
  
  private
  
  def set_request_params(params)
    params.each do |method, value|
      if respond_to?("#{method}=")
        self.send "#{method}=", value
      end
    end
    @ebay_site = params[:ebay_site_id] || 'US'
    @max_entries ||= 100
    @page_number ||= 1
    @category_id = category_id.to_i.zero? ? nil : computer_category_for(ebay_site)
  end
  
  def get_ebay_response
    params = {
      :query_keywords => keywords,
      :website        => ebay_site,
      :page_number    => page_number,
      :max_entries    => max_entries,
      :category_id    => category_id,
    }    
    params.merge!(:items_located_in => items_location) if restricted?
    EbayFinder::Request.new(params).response
  end
  
  def restricted?
    ebay_site != 'US' || ebay_site != 'IT' || ebay_site != 'DE' || ebay_site != 'FR'
  end
  
  def items_location
    ebay_site == 'UK' ? 'GB' : ebay_site
  end
  
  def computer_category_for(site)
    website = EbaySite.find(site)
    case website.currency_id
    when 'EUR'
      160
    else
      58058
    end
  end
end