class ClassController < ApplicationController
  def subjects
    render json: ActiveClass.find(params[:id]).subjects
  end

  # def lessons
  #   if params[:id]
  #     if params[:school_id]
  #       @school = School.find(params[:school_id])
  #       if @school.grade_id == 7
  #         @class = ActiveClass.find(params[:id])
  #         @lessons = Lesson.joins(:user).where(class_id: params[:id], type_id: params[:type_id]).paginate(page: params[:page], per_page: 30)
  #       elsif @school.grade_id != 5
  #         @class = ActiveClass.find(params[:id])
  #         @lessons = Lesson.joins(:user).where(users: {school_id: params[:school_id]}, class_id: params[:id], type_id: params[:type_id]).paginate(page: params[:page], per_page: 30)
  #       else
  #         @class = ActiveClass.find(params[:id])
  #         @lessons = Lesson.joins(user: :school).where("schools.pdt_id = ? OR schools.id = ?", @school.id, @school.id).where(class_id: params[:id], type_id: params[:type_id]).paginate(page: params[:page], per_page: 30)
  #       end
  #     else
  #       @class = ActiveClass.find(params[:id])
  #       @lessons = Lesson.joins(:user).where(class_id: params[:id], type_id: params[:type_id]).paginate(page: params[:page], per_page: 30)
  #     end
  #   else
  #     @class = ActiveClass.where(name: params[:name]).take
  #     logger = Logger.new(STDOUT)
  #     logger.info("I'm here")
  #     @lessons = Lesson.joins(:user).where(class_id: @class.id, type_id: params[:type_id]).paginate(page: params[:page], per_page: 30)
  #   end
  # end

  def lessons
    @class = ActiveClass.find(params[:id])
    @subjects = @class.subjects

    if @subjects.any?
      @subject_lessons = Array.new
      @type_id = params[:type_id]

      if params[:school_id]
        @school = School.find(params[:school_id])

        if @school.grade_id == 5
          @subjects.each do |subject|
            subject_lesson = SubjectLesson.new
            subject_lesson.subject = subject
            quantity = Lesson.joins(user: :school).where("schools.pdt_id = ? OR schools.id = ?", @school.id, @school.id).where(class_id: @class.id, type_id: @type_id, subject_id: subject.id).size
            lessons = Lesson.joins(user: :school).where("schools.pdt_id = ? OR schools.id = ?", @school.id, @school.id).where(class_id: @class.id, type_id: @type_id, subject_id: subject.id).limit(10)
            subject_lesson.quantity = quantity
            subject_lesson.lessons = lessons
            @subject_lessons.push(subject_lesson)
          end
        elsif @school.grade_id == 7
          @subjects.each do |subject|
            subject_lesson = SubjectLesson.new
            subject_lesson.subject = subject
            quantity = Lesson.joins(:user).where(class_id: @class.id, type_id: @type_id, subject_id: subject.id).size
            lessons = Lesson.joins(:user).where(class_id: @class.id, type_id: @type_id, subject_id: subject.id).limit(10)
            subject_lesson.quantity = quantity
            subject_lesson.lessons = lessons
            @subject_lessons.push(subject_lesson)
          end
        else
          @subjects.each do |subject|
            subject_lesson = SubjectLesson.new
            subject_lesson.subject = subject
            quantity = Lesson.joins(:user).where(users: {school_id: @school.id}, class_id: @class.id, type_id: @type_id, subject_id: subject.id).size
            lessons = Lesson.joins(:user).where(users: {school_id: @school.id}, class_id: @class.id, type_id: @type_id, subject_id: subject.id).limit(10)
            subject_lesson.quantity = quantity
            subject_lesson.lessons = lessons
            @subject_lessons.push(subject_lesson)
          end
        end
      else
        @subjects.each do |subject|
          subject_lesson = SubjectLesson.new
          subject_lesson.subject = subject
          quantity = Lesson.joins(:user).where(class_id: @class.id, type_id: @type_id, subject_id: subject.id).size
          lessons = Lesson.joins(:user).where(class_id: @class.id, type_id: @type_id, subject_id: subject.id).limit(10)
          subject_lesson.quantity = quantity
          subject_lesson.lessons = lessons
          @subject_lessons.push(subject_lesson)
        end
      end
    else
      if params[:school_id]
        @school = School.find(params[:school_id])
        if @school.grade_id == 7
          @class = ActiveClass.find(params[:id])
          @lessons = Lesson.joins(:user).where(class_id: params[:id], type_id: params[:type_id]).paginate(page: params[:page], per_page: 30)
        elsif @school.grade_id != 5
          @class = ActiveClass.find(params[:id])
          @lessons = Lesson.joins(:user).where(users: {school_id: params[:school_id]}, class_id: params[:id], type_id: params[:type_id]).paginate(page: params[:page], per_page: 30)
        else
          @class = ActiveClass.find(params[:id])
          @lessons = Lesson.joins(user: :school).where("schools.pdt_id = ? OR schools.id = ?", @school.id, @school.id).where(class_id: params[:id], type_id: params[:type_id]).paginate(page: params[:page], per_page: 30)
        end
      else
        @class = ActiveClass.find(params[:id])
        @lessons = Lesson.joins(:user).where(class_id: params[:id], type_id: params[:type_id]).paginate(page: params[:page], per_page: 30)
      end
    end
  end

  def show_lessons
    redirect_to "/classes/" + params[:name] + "/lessons"
  end
end
