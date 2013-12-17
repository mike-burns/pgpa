class ByTotpsController < ApplicationController
  def create
    @uid = Uid.find_by_email(params[:session][:email])
    if @uid && @uid.verified_totp?(params[:session][:totp])
      session[:user_id] = @uid.user.id
      redirect_to @uid.user
    else
      @uid.errors.add('invalid email or one-time password')
      render 'sessions/new'
    end
  end
end
