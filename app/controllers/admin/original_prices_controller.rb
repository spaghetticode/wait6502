class Admin::OriginalPricesController < ApplicationController
  before_filter :require_logged_in
  before_filter :find_purchaseable, :except => [:tainted]
  
  def create
    @original_price = @purchaseable.original_prices.build(params[:original_price])
    if @original_price.save
      flash[:notice] = 'Original Price was successfully created.'
    else
      flash[:error] = "Original price is not valid: #{@original_price.errors.full_messages.join(', ')}"
    end
    redirect_to purchaseable_edit_path
  end

  def destroy
    @purchaseable.original_prices.find(params[:id]).destroy
    flash[:notice] = 'Original price was successfully destroyed.'
    redirect_to purchaseable_edit_path
  end
  
  private
  
  def find_purchaseable
    params.each do |name, value|
      if name =~ /^(\w+)_id$/
        @purchaseable = $1.classify.constantize.find(value)
      end
    end
  end
  
  def purchaseable_edit_path
    send("edit_admin_#{@purchaseable.class.name.downcase}_path", @purchaseable)
  end
end
