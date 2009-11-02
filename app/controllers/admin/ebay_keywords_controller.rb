class Admin::EbayKeywordsController < ApplicationController
  include Admin::EbayKeywordsHelper
  before_filter :require_logged_in, :find_searchable
  layout 'admin'
  
  def index
    @ebay_keywords = @searchable.ebay_keywords.ordered    
  end

  def new
    @ebay_keyword = EbayKeyword.new
  end
  
  def create
    @ebay_keyword = @searchable.ebay_keywords.build(params[:ebay_keyword])
    if @ebay_keyword.save
      flash[:notice] = 'Ebay Keyword was successfully created.'
      redirect_to admin_searchable_ebay_keywords_path(@searchable)
    else
      render :action => 'new'
    end
  end

  def destroy
    @searchable.ebay_keywords.destroy(params[:id])
    flash[:notice] = 'Ebay Keyword was successfully destroyed.'
    redirect_to admin_searchable_ebay_keywords_path(@searchable)
  end

  private
  
  def find_searchable
    params.each_pair do |parameter, value|
      if parameter =~/(\w+)_id$/
        @searchable = $1.classify.constantize.find(value)
      end
    end
  end
end
