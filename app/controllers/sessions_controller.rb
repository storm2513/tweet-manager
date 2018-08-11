class SessionsController < ApplicationController
  def create
    @user = OauthService.find_or_create_user(auth_hash)
    session[:user_id] = @user.id
    flash[:success] = 'You was successfully authorized'
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You was successfully logged out'
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
