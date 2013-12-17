class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
    @user.keys.build
    @user.uids.build
  end

  def show
    @user = current_user
  end

  private

  def current_user
    User.find(session[:user_id])
  end
end
