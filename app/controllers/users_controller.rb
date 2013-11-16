class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
    @user.keys.build
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.begin_auth
    else
      render :new
    end
  end

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(keys_attributes: [ :keyid ])
  end

  def current_user
    User.find(session[:user_id])
  end
end
