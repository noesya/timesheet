class DashboardController < ApplicationController 
  def index
    @themes = Theme.all
    @week = Week.previous
    @user = current_user
  end
end
