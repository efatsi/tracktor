module CurrentUserHelper

  def logged_in?
    current_user.present?
  end

  def current_user
    @current_user ||= User.first(:token => request.cookies['user_token'])
  end

  def token_user
    User.first(:token => params[:token])
  end

  def require_login
    redirect "/" unless logged_in?
  end

end
