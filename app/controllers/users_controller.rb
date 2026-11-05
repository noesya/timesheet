class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]

  def index
    @users = User.all
    @years = Year.ordered
  end

  def show
    @years = Year.ordered
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to user_url(@user), notice: "User was successfully updated."
  end
  
  protected

  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :cost_per_day)
  end

end
  