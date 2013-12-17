class TotpsController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      @uid = @user.uids.last
      render
    else
      render 'users/new'
    end
  end

  private

  def user_params
    params.require(:user).permit(uids_attributes: [ :email ])
  end
end
