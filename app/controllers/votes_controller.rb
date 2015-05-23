class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create
    if params[:answer_id]
      commentable = Answer.find_by(id: params[:answer_id])
    else
      commentable = Question.find_by(id:params[:question_id])
    end
    commentable.votes.build(score: params[:score], user_id: current_user.id)
    if !commentable.save
      flash[:warning] = "Couldn't save vote"
    end
    if request.xhr?
      respond_to do |format|
        result = commentable.karma
        format.json  { render :json => result }
      end
    else
      redirect_to :back
    end
  end

end