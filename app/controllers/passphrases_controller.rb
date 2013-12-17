class PassphrasesController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      render 'users/new'
    end
  end

  private

  def user_params
    params.require(:user).permit(uids_attributes: [ :email, :passphrase ])
  end
end
