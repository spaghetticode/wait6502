class UserSessionsController < ApplicationController
  before_filter :require_logged_in, :only => :destroy
  before_filter :require_logged_out, :except => :destroy
  layout 'admin'
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = 'User successfully logged in'
      redirect_to root_path
    else
      render :action => 'new'
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = 'User successfully logged out'
    redirect_to root_path
  end
end