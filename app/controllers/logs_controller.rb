class LogsController < ApplicationController

  def create
    week = Week.find params[:week]
    theme = Theme.find params[:theme]
    user = User.find params[:user]
    Log.write week, theme, user
    redirect_back fallback_location: root_path, status: :see_other
  end

  def update
    @log = Log.find params[:id]
    if @log.update(log_params)
      respond_to do |format|
        format.js { head :no_content }
        format.html { redirect_back fallback_location: root_path, status: :see_other }
      end
    else
      head :unprocessable_content
    end
  end

  private

  def log_params
    params.require(:log).permit(:cycle_id)
  end
end
