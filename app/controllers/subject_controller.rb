class SubjectController < ApplicationController
  def lessons
    if params[:school_id]
      @school = School.find(params[:school_id])
      if @school.grade_id == 7
        @lessons = Lesson.where(class_id: params[:class_id], subject_id: params[:subject_id], type_id: params[:type_id]).paginate(page: params[:page], per_page: 30)
      elsif @school.grade_id != 5
        @lessons = Lesson.joins(:user).where(users: {school_id: params[:school_id]}, class_id: params[:class_id], subject_id: params[:subject_id], type_id: params[:type_id]).paginate(page: params[:page], per_page: 30)
      else
        @lessons = Lesson.joins(user: :school).where(schools: {pdt_id: @school.id}, class_id: params[:class_id], subject_id: params[:subject_id], type_id: params[:type_id]).paginate(page: params[:page], per_page: 30)
      end
    else
      @lessons = Lesson.where(class_id: params[:class_id], subject_id: params[:subject_id], type_id: params[:type_id]).paginate(page: params[:page], per_page: 30)
    end
  end
end
