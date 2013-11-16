class SessionsController < ApplicationController
  def new
  end

  def create
    @uid = Uid.find_by_email(params[:session][:email])
    if @uid
      @uid.begin_auth
    else
      @uid.errors.add(:email, 'no such uid')
      render :new
    end
  end
end
