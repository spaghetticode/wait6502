class Admin::ResultsetsController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def create
    keyword = CGI.escape(params[:keyword])
    site = params[:ebay_site]
    page = params[:page] || 1
    raise ArgumentError, "http://svcs.ebay.com/services/search/FindingService/v1?OPERATION-NAME=findItemsByKeywords&SERVICE-VERSION=1.0.0&SECURITY-APPNAME=#{APP_CONFIG['ebay_app_id']}&RESPONSE-DATA-FORMAT=XML&GLOBAL-ID=EBAY-#{site}&REST-PAYLOAD&keywords=#{keyword}&paginationInput.entriesPerPage=40&sortOrder=EndTimeSoonest&paginationInput.pageNumber=#{page}"
  end
end
