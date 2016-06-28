class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to root_url
    end

    store_referrer_location if session[:return_to].blank?
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      # Log the users in and redirect to the users's show page.
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      remember user
      redirect_back_or_default root_url
    else
      flash.now[:danger] = 'Sai tên đăng nhập hoặc mật khẩu' # Not quite right!
      # Create an error message.
      render 'new'
    end
  end
end 
