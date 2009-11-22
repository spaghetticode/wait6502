class OriginalPricesController < ApplicationController
  before_filter :find_purchaseable
  layout 'museum'
  
  def create_tainted
    respond_to do |format|
      format.js do
        @original_price = @purchaseable.original_prices.build(params[:original_price])
        @original_price.tainted = true
        if @original_price.save
          @valid = true
        else
          @valid = false
        end
      end
      format.html
    end
  end
  
  private
  
  def find_purchaseable
    params.each do |name, value|
      if name =~ /^(\w+)_id$/
        @purchaseable = $1.classify.constantize.find(value)
      end
    end
  end
end
