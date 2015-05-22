class CommentsController < ApplicationController
  before_filter :find_comment

  def create

  end

  def edit
  end

  def update
    if @comment.update_attributes(params[:comment])
      flash[:success] = "Comment updated."
      redirect_to question_path(@comment)
    else
      flash[:error] = "That was an invalid comment."
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