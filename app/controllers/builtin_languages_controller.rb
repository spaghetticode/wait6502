class BuiltinLanguagesController < ApplicationController
  layout 'museum'
  
  def index
    @builtin_languages = BuiltinLanguage.ordered
  end

  def show
    @builtin_language = BuiltinLanguage.find(params[:id])
  end

end
