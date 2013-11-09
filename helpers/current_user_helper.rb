module CurrentUserHelper

  def logged_in?
    current_user.present?
  end

  def current_user
    User.first(:token => session[:user_token])
  end

end
