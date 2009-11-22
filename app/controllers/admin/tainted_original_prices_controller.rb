class Admin::TaintedOriginalPricesController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @tainted_prices = OriginalPrice.tainted.ordered
  end
  
  def edit
    @tainted_price = OriginalPrice.find(params[:id])
  end
  
  def approve
    @tainted_price = OriginalPrice.find(params[:id])
    @tainted_price.update_attribute(:tainted, nil)
    flash[:notice] = 'Original price was successfully approved.'
    redirect_to admin_tainted_original_prices_path
  end
  
  def update
    @tainted_price = OriginalPrice.find(params[:id])
    if @tainted_price.update_attributes(params[:tainted_price])
      flash[:notice] = 'Original Price was successfully updated.'
      redirect_to admin_tainted_original_prices_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @tainted_price = OriginalPrice.find(params[:id])
    if @tainted_price.tainted
      @tainted_price.destroy
      flash[:notice] = 'Original Price was successfully destroyed.'
    else
      flash[:error] = 'You cannot destroy this original price, as it is already approved.'
    end
    redirect_to admin_tainted_original_prices_path
  end

end
