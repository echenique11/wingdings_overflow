class Question < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :answers
  has_many :comments, as: :commentable
  has_many :votes, as: :voteable

  validates :title, :body, :user_id, presence: :true

  def karma
    all_votes = Vote.where(voteable_id: id, voteable_type: "Question")
    all_votes.sum(:score)
  end
end