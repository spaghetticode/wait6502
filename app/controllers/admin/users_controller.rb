class Admin::UsersController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @users = User.ordered
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'User successfully created'
      redirect_to root_path
    else
      render :action => 'new'
    end
  end
end
