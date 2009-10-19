class Admin::CountriesController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @countries = Country.ordered.paginate(:page => params[:page])
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new(params[:country])
    if @country.save
      flash[:notice] = 'Country was successfully created.'
      redirect_to admin_countries_path
    else
      render :action => "new"
    end
  end

  def destroy
    Country.find(params[:id]).destroy
    flash[:notice] = 'Country was successfully destroyed.'
    redirect_to admin_countries_path
  end
end
