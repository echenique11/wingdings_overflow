class CommentsController < ApplicationController
  before_filter :find_comment

  def create
    p params
    if params[:answer_id]
      commentable = Answer.find_by(id: params[:answer_id])
    else
      commentable = Question.find_by(id: params[:question_id])
    end

    commentable.comments.build(body: params[:body], user_id: current_user.id)
    if commentable.save
      redirect_to question_path(params[:question_id])
    else
      flash[:warning] = "That was an invalid comment."
      redirect_to :back
    end
  end

  def edit
  end

  def update
    if @comment.update_attributes(params[:comment])
      flash[:success] = "Comment updated."
      redirect_to question_path(@comment)
    else
      flash[:warning] = "That was an invalid comment."
      render :edit
    end
  end

  def destroy
    @comment.delete
    redirect_to :back
  end

  private

  def find_comment
    @comment = Comment.find_by(id: params[:id]) if params[:id]
  end
end