class Resultset
  attr_reader :items, :page, :total_items, :total_pages
  def initialize(params)
    ebay_params = {
      :keywords => params[:keyword],
      :website => "EBAY-#{params[:ebay_site]}",
      :pagination_input => {
        :entries_per_page => 30, 
        :page_number => params[:page] || 1
      }
    }
    response = EbayFinder::Request.new(ebay_params).response
    @items = response.items
    @total_items = response.total_items
  end
end