class CommentsController < ApplicationController
  def create
    lesson = Lesson.find(params[:lesson_id])
    @comment = Comment.new(comment_params)
    @comment.lesson = lesson
    @comment.user_id = current_user.id
    @comment.save
    #detail look at here: https://masteruby.github.io/weekly-rails/2014/08/08/how-to-add-comments-to-rails-app.html#.VuFOHdKF7cs
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
