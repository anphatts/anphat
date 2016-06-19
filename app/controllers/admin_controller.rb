class AdminController < ApplicationController
  def manage_user
    @users = User.all
  end

  def update_users
    params['user'].keys.each do |id|
      @user = User.find(id.to_i)
      @user.update_attributes(params['user'][id])
    end
    redirect_to manage_user_path
  end

  def manage_lesson

  end
end
