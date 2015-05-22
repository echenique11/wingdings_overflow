class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :votes, as: :voteable


  # def karma
  #   all_votes = Vote.where(voteable_id: id, voteable_type: "Question")
  #   all_votes.sum(:score)
  # end
end
