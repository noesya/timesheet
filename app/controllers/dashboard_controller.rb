class DashboardController < ApplicationController 
  def index
    @themes = Theme.all
    @week = Week.current.previous
    @user = current_user
  end

  def log
    log = Log.where(
      week_id: params[:week],
      theme_id: params[:theme],
      user_id: params[:user]
    ).first_or_create
    log.increment
    redirect_back fallback_location: log.week
  end
end