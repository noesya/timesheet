class DashboardController < ApplicationController 
  def index
    @themes = Theme.all
    @week = Week.current.previous
  end

  def log
    log = Log.where(
      week_id: params[:week],
      theme_id: params[:theme],
      user: current_user
    ).first_or_create
    log.increment
    redirect_to log.week
  end
end