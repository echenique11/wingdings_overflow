class CommentsController < ApplicationController
  before_filter :find_comment

  def new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to comment_path(@comment)
    else
      flash[:error] = "That was an invalid comment."
      render :new
    end
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

  def comment_params
    params.require(:comment).permit(:title, :body).merge(user_id: current_user.id )
  end
end