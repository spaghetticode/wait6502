class Admin::ResultsetsController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  
  def create
    @resultset = Resultset.new(params)
  end
end
