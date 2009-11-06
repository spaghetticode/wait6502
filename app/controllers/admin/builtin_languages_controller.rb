class Admin::BuiltinLanguagesController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @builtin_languages = BuiltinLanguage.ordered.paginate(:page => params[:page])
  end

  def new
    @builtin_language = BuiltinLanguage.new

  end

  def create
    @builtin_language = BuiltinLanguage.new(params[:builtin_language])
      if @builtin_language.save
        flash[:notice] = 'Builtin language was successfully created.'
        redirect_to admin_builtin_languages_path
      else
        render :action => "new"
      end
  end

  def delete
    @builtin_language = BuiltinLanguage.find(params[:id])
    if @builtin_language.hardware.empty?
      @builtin_language.destroy
      flash[:notice] = 'Builtin language was successfully destroyed.'
    else
      flash[:error] = 'Can\'t destroy: language still has some hardware associated.'
    end
    redirect_to admin_builtin_languages_path
  end
end
