class BuiltinStoragesController < ApplicationController
  layout 'museum'
  
  def index
    @storages = BuiltinStorage.ordered
  end

  def show
    @storage = BuiltinStorage.find(params[:id])
  end
end
