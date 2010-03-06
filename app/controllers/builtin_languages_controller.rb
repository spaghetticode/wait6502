class BuiltinLanguagesController < ApplicationController
  layout 'museum'
  
  def index
    @builtin_languages = BuiltinLanguage.ordered
  end

  def show
    @builtin_language = BuiltinLanguage.find_by_permalink(params[:id])
    unless @builtin_language
      id = params[:id].downcase.gsub(/\s|%20|\+/, '-')
      language = BuiltinLanguage.find_by_permalink(id)
      if language
        headers["Status"] = "301 Moved Permanently"  
        redirect_to :action => 'show', :id => id
        return
      end
    end
    session[:return_to] = {
      :name => "#{@builtin_language.name.downcase} language",
      :url => request.request_uri
    }
  end
end
