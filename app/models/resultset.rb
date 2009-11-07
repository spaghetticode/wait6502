class Resultset
  attr_reader :items, :total_items, :ebay_site
  def initialize(params)
    ebay_params = {
      :query_keywords => params[:keyword],
      :website => params[:ebay_site],
      :max_entries => 30, 
      :page_number => params[:page] || 1
    }
    response = EbayFinder::Request.new(ebay_params).response
    @items = response.items
    @total_items = response.total_items
    @ebay_site = EbaySite.find_by_site_id(params[:ebay_site])
  end
end