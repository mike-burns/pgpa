class CompletersController < ApplicationController
  def show
    user = User.find_by_secret(params[:id])
    if user
      sign_in(user)
      redirect_to user
    else
      redirect_to new_session_path, error: 'Invalid URL'
    end
  end

  private

  def sign_in(user)
    session[:user_id] = user.id
  end
end
