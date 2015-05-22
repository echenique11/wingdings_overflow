class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create
    p params
    if params[:answer_id]
      commentable = Answer.find_by(id: params[:answer_id])
    else
      commentable = Question.find_by(id:params[:question_id])
    end

    commentable.votes.build(score: params[:score], user_id: current_user.id)
    if commentable.save
      redirect_to :back
    else
      flash[:warning] = "Couln't save vote"
      redirect_to :back
    end
  end

end