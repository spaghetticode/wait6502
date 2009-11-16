class BrandsController < ApplicationController
  layout 'default'

  def index
    @brands = Manufacturer.ordered
  end

  def show
    @brand = Manufacturer.find(params[:id])
  end

end
