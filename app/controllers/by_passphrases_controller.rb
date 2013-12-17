class ByPassphrasesController < ApplicationController
  def create
    @uid = Uid.find_by_email(params[:session][:email])
    if @uid && @uid.verified_passphrase?(params[:session][:passphrase])
      session[:user_id] = @uid.user.id
      redirect_to @uid.user
    else
      @uid.errors.add('invalid email or passphrase')
      render 'sessions/new'
    end
  end
end
