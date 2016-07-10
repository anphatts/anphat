class TypeController < ApplicationController
  def lessons
    if params[:school_id]
      @school = School.find(params[:school_id])

      if @school.grade_id == 5
        @classes = @school.active_classes
        @class_lessons = Array.new
        @type_id = params[:type_id]
        @classes.each do |active_class|
          class_lesson = ClassLesson.new
          class_lesson.class = active_class
          quantity = Lesson.joins(user: :school).where("schools.pdt_id = ? OR schools.id = ?", @school.id, @school.id).where(class_id: active_class.id, type_id: @type_id).size
          lessons = Lesson.joins(user: :school).where("schools.pdt_id = ? OR schools.id = ?", @school.id, @school.id).where(class_id: active_class.id, type_id: @type_id).limit(10)
          class_lesson.quantity = quantity
          class_lesson.lessons = lessons
          @class_lessons.push(class_lesson)
        end
      elsif @school.grade_id == 7
        @classes = ActiveClass.all.order('id ASC')
        @class_lessons = Array.new
        @type_id = params[:type_id]
        @classes.each do |active_class|
          class_lesson = ClassLesson.new
          class_lesson.class = active_class
          quantity = Lesson.joins(:user).where(class_id: active_class.id, type_id: @type_id).size
          lessons = Lesson.joins(:user).where(class_id: active_class.id, type_id: @type_id).limit(10)
          class_lesson.quantity = quantity
          class_lesson.lessons = lessons
          @class_lessons.push(class_lesson)
        end
      else
        @classes = @school.active_classes
        @class_lessons = Array.new
        @type_id = params[:type_id]
        @classes.each do |active_class|
          class_lesson = ClassLesson.new
          class_lesson.class = active_class
          quantity = Lesson.joins(:user).where(users: {school_id: @school.id}, class_id: active_class.id, type_id: @type_id).size
          lessons = Lesson.joins(:user).where(users: {school_id: @school.id}, class_id: active_class.id, type_id: @type_id).limit(10)
          class_lesson.quantity = quantity
          class_lesson.lessons = lessons
          @class_lessons.push(class_lesson)
        end
      end
    else
      @classes = ActiveClass.all.order('id ASC')
      @class_lessons = Array.new
      @type_id = params[:type_id]
      @classes.each do |active_class|
        class_lesson = ClassLesson.new
        class_lesson.class = active_class
        quantity = Lesson.joins(:user).where(class_id: active_class.id, type_id: @type_id).size
        lessons = Lesson.joins(:user).where(class_id: active_class.id, type_id: @type_id).limit(10)
        class_lesson.quantity = quantity
        class_lesson.lessons = lessons
        @class_lessons.push(class_lesson)
      end
    end
  end
end
