class UsersController < ApplicationController
  def index
    @users = User.all
    @years = Year.ordered
  end

  def show
    @user = User.find params[:id]
    @years = Year.ordered
  end
end
  