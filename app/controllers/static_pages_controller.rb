class StaticPagesController < ApplicationController

  def home
    if current_user && current_user.school && current_user.school != 7
      @school = current_user.school
      if @school.grade_id == 5 || @school.grade_id == 7
        @phongdaotao = @school
      else
        @phongdaotao = @school.phongdaotao
      end
      @classes = @school.active_classes
      @type_lessons = Array.new
      @type = Type.all
      @type.each do |type|
        type_lesson = TypeLesson.new
        type_lesson.type = type
        quantity = Lesson.joins(:user).where(users: {school_id: @school.id}, type_id: type.id).size
        lessons = Lesson.joins(:user).where(users: {school_id: @school.id}, type_id: type.id).limit(10)
        type_lesson.quantity = quantity
        type_lesson.lessons = lessons
        @type_lessons.push(type_lesson)
      end
    else
      @classes = ActiveClass.all.order('id ASC')
      @type_lessons = Array.new
      @type = Type.all
      @type.each do |type|
        type_lesson = TypeLesson.new
        type_lesson.type = type
        quantity = Lesson.joins(:user).where(type_id: type.id).size
        lessons = Lesson.joins(:user).where(type_id: type.id).limit(10)
        type_lesson.quantity = quantity
        type_lesson.lessons = lessons
        @type_lessons.push(type_lesson)
      end
    end
  end

  def help

  end

  def contact
  end

  def about
  end

end