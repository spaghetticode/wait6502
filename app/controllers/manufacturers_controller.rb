class ManufacturersController < ApplicationController
  layout 'museum'

  def index
    @manufacturers = Manufacturer.ordered
  end

  def show
    @manufacturer = Manufacturer.find(params[:id])
  end

end
