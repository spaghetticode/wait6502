class Admin::ResultsetsController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def create
    if params[:resultset][:keywords].blank?
      flash[:error] = 'You must provide a search keyword.'
      redirect_to admin_auctions_path
    else
      @resultset = Resultset.new(params[:resultset])
      @resultset.set_results
      @item_ids = Auction.item_ids
      render :action => 'show'
    end
  end
end
