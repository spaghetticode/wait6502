class Admin::OriginalPricesController < ApplicationController
  before_filter :require_logged_in, :find_purchasable
  
  def create
    @original_price = @purchasable.original_prices.build(params[:original_price])
    if @original_price.save
      flash[:notice] = 'Original Price was successfully created.'
    else
      flash[:error] = "Original price is not valid: #{@original_price.errors.full_messages.join(', ')}"
    end
    redirect_to purchasable_edit_path
  end

  def destroy
    @purchasable.original_prices.find(params[:id]).destroy
    flash[:notice] = 'Original price was successfully destroyed.'
    redirect_to purchasable_edit_path
  end

  private
  
  def find_purchasable
    params.each do |name, value|
      if name =~ /^(\w+)_id$/
        @purchasable = $1.classify.constantize.find(value)
      end
    end
  end
  
  def purchasable_edit_path
    send("edit_admin_#{@purchasable.class.name.downcase}_path", @purchasable)
  end
end
