class Admin::CurrenciesController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @currencies = Currency.ordered.paginate(:page => params[:page])
  end

  def show
    @currency = Currency.find(params[:id])
  end

  def new
    @currency = Currency.new
  end

  def edit
    @currency = Currency.find(params[:id])
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

  def update
    @currency = Currency.find(params[:id])
    if @currency.update_attributes(params[:currency])
      flash[:notice] = 'Currency was successfully updated.'
      redirect_to admin_currencies_path
    else
      render :action => "edit"
    end
  end

  def destroy
    Currency.find(params[:id]).destroy
    flash[:notice] = 'Currency was successfully destroyed.'
    redirect_to admin_currencies_path
  end
end
