class Admin::AuctionsController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @auctions = Auction.paginate(:page => params[:page])
  end
  
  def new
    @auction = Auction.new
  end

  def edit
    @auction = Auction.find(params[:id])
  end

  def create
    @auction = Auction.new(params[:auction])
    if @auction.save
      flash[:notice] = 'Auction was successfully created.'
      redirect_to admin_auctions_path
    else
      render :action => "new"
    end
  end

  def update
    @auction = Auction.find(params[:id])
    if @auction.update_attributes(params[:auction])
      flash[:notice] = 'Auction was successfully updated.'
      redirect_to admin_auctions_path
    else
      raise "#{@auction.to_yaml}"
      render :action => "edit"
    end
  end

  def destroy
    Auction.find(params[:id]).destroy
    flash[:notice] = 'Auction was successfully destroyed.'
    redirect_to admin_auctions_path
  end
end
