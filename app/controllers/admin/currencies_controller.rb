class Admin::CurrenciesController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @currencies = Currency.ordered.paginate(:page => params[:page])
  end

  def new
    @currency = Currency.new
  end

  def create
    @currency = Currency.new(params[:currency])
    if @currency.save
      flash[:notice] = 'Currency was successfully created.'
      redirect_to admin_currencies_path
    else
      render :action => "new"
    end
  end

  def destroy
    @currency = Currency.find(params[:id])
    if @currency.unused?
      @currency.destroy
      flash[:notice] = 'Currency was successfully destroyed.'
    else
      flash[:error] = 'Currency is still used by some auction, price or ebay site.'
    end
    redirect_to admin_currencies_path
  end
end
