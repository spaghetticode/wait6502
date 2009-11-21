class BuiltinStoragesController < ApplicationController
  layout 'museum'
  
  def index
    @storages = BuiltinStorage.ordered
  end

  def show
    @storage = BuiltinStorage.find(params[:id])
    session[:return_to] = {
      :name => @storage.full_name,
      :url => request.request_uri
    }
  end
end
