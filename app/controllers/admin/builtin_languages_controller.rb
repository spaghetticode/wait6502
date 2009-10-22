class Admin::BuiltinLanguagesController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def index
    @builtin_languages = BuiltinLanguage.all
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
    BuiltinLanguage.find(params[:id]).destroy
    flash[:notice] = 'Builtin language was successfully destroyed.'
    redirect_to admin_builtin_languages_path
  end
end
