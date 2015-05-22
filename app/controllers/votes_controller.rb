class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create
    if params[:answer_id]
      voteable = Answer.find_by(id: params[:answer_id])
    else
      voteable = Question.find_by(id:params[:question_id])
    end

    voteable.votes.build(score: params[:score], user_id: current_user.id)
    if voteable.save
      redirect_to :back
    else
      flash[:warning] = "Couln't save vote"
      redirect_to :back
    end
  end

end