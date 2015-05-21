class CommentsController < ApplicationController
  before_filter :find_comment



  private
  def find_comment
    @model = Comment.find_by(id: params[:id]) if params[:id]
  end
end