module SessionsHelper
  # Logs in the given users.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in users (if any).
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Returns true if the users is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current users.
  def log_out
    if (current_user)
      forget(current_user)
      session.delete(:user_id)
      @current_user = nil
    end
  end

  # Remembers a users in a persistent session.
  def remember(user)
    user.remember
    cookies.signed[:user_id] = {value: user.id, expires: 8.hours.from_now}
    cookies[:remember_token] = {value: user.remember_token, expires: 8.hours.from_now}
  end

end
