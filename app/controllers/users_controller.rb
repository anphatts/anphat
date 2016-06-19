class UsersController < ApplicationController
  before_action :admin_user, only: :destroy

  def index
    if params[:school_id]
      render json: User.select(:username, :name).where(school_id: params[:school_id])
    else
      render json: User.all.select(:username, :name);
    end
  end

  def show
    @user = User.find(params[:id])
    @lessons = @user.lessons.paginate(page: params[:page], per_page: 15)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
      log_in @user
      flash[:success] = "Đã thêm người dùng thành công!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Xóa thành công"
    redirect_to edit_all_path
  end

  # Confirms an admin user.
  def admin_user
    if (!current_user || current_user.username != 'admin')
      redirect_to(root_url)
    end
  end

  def create_by_admin
    @user = User.new(user_params.except(:role))
    @user.roles = Array.[](Role.find(user_params[:role]))
    if @user.save
      # Handle a successful save.
      flash[:success] = "Đã đăng ký thành công!"
      redirect_to edit_all_path
    else
      @roles = current_user.roles
      if params.has_key?(:school_id)
        @school = School.find(params[:school_id])
      else
        @school = nil
      end
      params[:school_id] ? @users = User.all.where(school_id: @school.id) : @users = User.all.where(school_id: nil)
      @created_user = @user
      render 'edit_all'
    end
  end

  def edit_all
    @roles = current_user.roles
    if params.has_key?(:school_id)
      @school = School.find(params[:school_id])
    else
      @school = nil
    end
    params[:school_id] ? @users = User.all.where(school_id: @school.id) : @users = User.all.where(school_id: nil)
  end

  def update_all
    params['user'].keys.each do |id|
      @user = User.find(id.to_i)
      if @user.update_columns(params['user'][id].permit(:user, :name, :email, :school_id, :roles => [:id]).except(:roles))
        role_id = params['user'][id].permit(:user, :name, :email, :school_id, :roles => [:id])[:roles][:id];
        @user.roles = role_id.blank? ? [] : Array.[](Role.find(role_id));
        @user.save
      else
        flash[:success] = Rails.logger.info(@user.errors.messages.inspect)
      end
    end
    redirect_to(edit_all_path)
  end

  def inbox
    if current_user
      @lessons = current_user.assigned_lessons
    end
  end

  def list_of_downloads
    @user = User.find_by(username: params[:username])
    if @user
      @lessons = @user.download_lessons.paginate(page: params[:page], per_page: 15)
    else
      render application/not_found
    end
  end

  def change_password

  end

  def update_password
    if current_user
      if !current_user.authenticate(params[:user][:old_password])
        flash[:danger] = "Mật khẩu không đúng"
      else
        if current_user.update(params[:user].permit(:password, :password_confirmation))
          flash[:success] = "Đổi mật khẩu thành công"
        else
          flash[:danger] = "Mật khẩu xác nhận không giống nhau"
        end
      end
    end
    redirect_to change_password_path
  end

  private

  def user_params
    params.require(:user_new).permit(:name, :username, :email, :workplace, :password,
                                     :password_confirmation, :role, :school_id)
  end

end