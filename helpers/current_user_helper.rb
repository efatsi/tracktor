module CurrentUserHelper

  def logged_in?
    current_user.present?
  end

  def current_user
    session_user || cookie_user
  end

  def token_user
    User.first(:token => params[:token])
  end

  def require_login
    redirect "/" unless logged_in?
  end

  private

  def session_user
    User.first(:token => session[:user_token])
  end

  def cookie_user
    User.first(:token => request.cookies['user_token'])
  end

end
