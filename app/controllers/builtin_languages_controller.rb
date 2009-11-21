class BuiltinLanguagesController < ApplicationController
  layout 'museum'
  
  def index
    @builtin_languages = BuiltinLanguage.ordered
  end

  def show
    @builtin_language = BuiltinLanguage.find_by_permalink(params[:id])
    session[:return_to] = {
      :name => "#{@builtin_language.name.downcase} language",
      :url => request.request_uri
    }
  end
end
