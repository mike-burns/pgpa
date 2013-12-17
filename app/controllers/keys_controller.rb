class KeysController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      @user.begin_auth
    else
      render 'users/new'
    end
  end

  private

  def user_params
    params.require(:user).permit(keys_attributes: [ :keyid ])
  end
end
