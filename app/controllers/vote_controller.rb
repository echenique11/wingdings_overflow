class VoteController < ApplicationController::Base

  def create
    vote = Vote.new(vote_params)
    if vote.save!

    else
      render :new
      flash[:warn] = 'Was not able to save this comment'
    end
  end

 def vote_parms
    params.require(:vote).permit(:voteable_id, :voteable_type, :score).merge(user_id: current_user.id)
 end

end