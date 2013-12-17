class ByKeysController < ApplicationController
  def create
    @uid = Uid.find_by_email(params[:session][:email])
    if @uid
      @uid.begin_auth
    else
      @uid.errors.add(:email, 'no such uid')
      render 'sessions/new'
    end
  end
end
