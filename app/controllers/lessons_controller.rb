require 'zip'

class LessonsController < ApplicationController
  impressionist :actions => [:show, :details]

  def index
    @lessons = Lesson.all
  end

  def new
    if logged_in?
      @lesson = Lesson.new
      @school = current_user.school
      if @school
        @classes = @school.active_classes.order(:id)
      end
      @types = Type.all
    end
  end

  def get_content
    @lessons = Lesson.all.paginate(page: params[:page], per_page: 30)
  end

  def create
    persons_in_charge_params = lesson_params[:persons_in_charge]
    @lesson = Lesson.new(lesson_params.except(:persons_in_charge))
    @lesson.user = current_user
    if @lesson.save
      if eval(lesson_params[:type_id]) == 1
        id = @lesson.id
        if !valid_zip?(@lesson.url.file.path)
          flash[:danger] = "Bài giảng không hợp lệ"
          @lesson.destroy
          path_to_lesson = @lesson.url.path
          File.delete(path_to_lesson) if File.exist?(path_to_lesson)
          @school = current_user.school
          @classes = @school.active_classes.order(:id)
          render 'new'
          return
        end
        Zip::File.open(@lesson.url.file.path) do |zipfile|
          zipfile.each do |file|
            f_path=File.join("public/uploads/#{id}/" + file.name)
            FileUtils.mkdir_p(File.dirname(f_path))
            zipfile.extract(file, f_path) unless File.exist?(f_path)
          end
        end

        if File.exists?("public/uploads/#{id}/index.html")
          File.rename("public/uploads/#{id}/index.html", "public/uploads/#{id}/index.htm")
        end
        if !File.exists?("public/uploads/#{id}/index.htm")
          flash[:danger] = "Bài giảng không hợp lệ"
          @lesson.destroy
          @lesson = nil
        end
      end

      if @lesson
        if @lesson.isAssignment && persons_in_charge_params.any?
          @lesson.persons_in_charge = User.where("username in (?)", persons_in_charge_params)
        end

        #redirect to lesson_path
        flash[:danger] = nil
        flash[:success] = "Tải lên baì giảng thành công"
      end
    end
    @school = current_user.school
    @classes = @school.active_classes.order(:id)
    render 'new'
  end

  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.destroy
    path_to_lesson = @lesson.url.path
    File.delete(path_to_lesson) if File.exist?(path_to_lesson)
    if @lesson.type_id == 1
      FileUtils.rm_rf("public/uploads/#{@lesson.id}") if File.directory?("public/uploads/#{@lesson.id}")
    end
    flash[:success] = "Bài giảng " + @lesson.name + " đã được xóa thành công"
    redirect_to root_path
  end

  def destroy_by_manager
    @lesson = Lesson.find(params[:id])
    @lesson.destroy
    path_to_lesson = @lesson.url.path
    File.delete(path_to_lesson) if File.exist?(path_to_lesson)
    if @lesson.type_id == 1
      FileUtils.rm_rf("public/uploads/#{@lesson.id}") if File.directory?("public/uploads/#{@lesson.id}")
    end
    flash[:success] = "Bài giảng " + @lesson.name + " đã được xóa thành công"
    redirect_to approve_path
  end

  def show
    @lessons = Lesson.find(params[:id])
    id = @lessons.id
    if id == 1
      redirect_to("/uploads/#{id}/index.htm")
    else
      render nothing: true
    end
  end

  def details
    @lesson = Lesson.find(params[:id])
    @school = @lesson.user.school
    @filesize = '%.2f' % (File.size(Rails.public_path.to_s + @lesson.url.url).to_f / 2**20)
    @downloads_count = Download.where(lesson_id: @lesson.id).count
    if @school.grade_id == 5
      @phongdaotao = @school
    else
      @phongdaotao = @school.phongdaotao
    end

    @comments = Comment.where(lesson_id: params[:id])
    commontator_thread_show(@lesson)

    # use for left menu
    if @school.grade_id == 5
      @phongdaotao = @school
      @classes = @school.active_classes
    else
      @phongdaotao = @school.phongdaotao
      @classes = @school.active_classes
    end
  end

  def search
    search = params[:search]
    if params[:school]
      school_id = params[:school][:id]
      type_id = params[:type][:id]
      class_id = params[:class][:id]
    end

    @lessons = Lesson.all
    if params[:school]
      if !school_id.empty?
        @lessons = Lesson.joins(:user).where(users: {school_id: params[:school][:id]})
      end
      if !class_id.empty?
        @lessons = @lessons.where(class_id: class_id)
      end
      if !type_id.empty?
        @lessons = @lessons.where(type_id: type_id)
      end
    end
    if !search.empty?
      @lessons = @lessons.where('lessons.name LIKE ?', "%#{search}%")
    end

    @lessons = @lessons.paginate(page: params[:page], per_page: 30)
    @search_content = search
  end

  def approve
    @lessons = Lesson.where(approved: false).order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end

  def update_approval
    params['lesson'].keys.each do |id|
      @lesson = Lesson.find(id.to_i)
      @lesson.update_columns(approver_id: current_user.id)
      if !@lesson.update_columns(params['lesson'][id].permit(:approved))
        flash[:success] = Rails.logger.info(@lesson.errors.messages.inspect)
      end
    end
    redirect_to(approve_path)
  end

  def download
    lesson = Lesson.find(params[:id])
    download = Download.new(user_id: current_user.id, lesson_id: lesson.id)
    if download.valid?
      download.save
    end
    send_file lesson.url.path
  end

  def advanced_search

  end

  private
  def lesson_params
    params.require(:lessons).permit(:name, :url, :subject_id, :class_id, :represent_image, :type_id, :isAssignment, :persons_in_charge)
  end

  def valid_zip?(file)
    zip = Zip::File.open(file)
    true
  rescue Zip::Error
    false
  ensure
    zip.close if zip
  end

end
