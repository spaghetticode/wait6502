class Admin::AuctionsController < ApplicationController
  include Admin::AuctionsHelper
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    scope = case params[:scope]
    when 'active'
      :active
    when 'closed'
      :closed
    else
      :ordered
    end
    conditions = [Auction.concat_query, "%#{params[:keywords]}%"] if params[:keywords]
    @auctions = Auction.send(scope).paginate(
      :page => params[:page],
      :conditions => conditions,
      :order => "#{params[:order] || 'end_time'} #{params[:desc]}",
      :include => :hardware      
    )
  end
  
  def new
    @auction = Auction.new
  end

  def edit
    @auction = Auction.find(params[:id])
  end

  def create
    @auction = Auction.new(params[:auction])
    respond_to do |f|
      if @auction.save
        f.html do
          flash[:notice] = 'Auction was successfully created.'
          redirect_to admin_auctions_path
        end
        f.js
      else
        f.html { render :action => "new" }
        f.js
      end
    end
  end

  def update
    @auction = Auction.find(params[:id])
    if @auction.update_attributes(params[:auction])
      flash[:notice] = 'Auction was successfully updated.'
      redirect_to admin_auctions_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @auction = Auction.find(params[:id])
    @auction.destroy
    respond_to do |f|
      f.html do
        flash[:notice] = 'Auction was successfully destroyed.'
        redirect_to admin_auctions_path
      end
      f.js
    end
  end
  
  def set_final_price
    @auction = Auction.find(params[:id])
    respond_to do |f|
      if @auction.set_final_price
        f.html do
          flash[:notice] = "Final Price for this auction was #{final_price_string(@auction)}"
          redirect_to admin_auctions_path
        end
        f.js
      else
        f.html do
          flash[:error]  = 'Auction went without bids. Please destroy it.'
          redirect_to admin_auctions_path
        end
        f.js
      end
    end
  end
end
