class SearchesController < ApplicationController
  layout 'museum'
  
  def create
    if params[:query].blank? or params[:query].size < 2 
      flash[:error] = 'Please refine your search keywords.'
      redirect_to :back and return
    else
      @search = Search.new(params[:query])
      @search.create
    end
    session[:return_to] = {
      :name => "search",
      :url => request.request_uri
    }
  end
end
