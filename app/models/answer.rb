class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :votes, as: :voteable
  has_many :comments, as: :commentable

  validates :body, :question_id, :user_id, presence: :true
  validates_uniqueness_of :question_id, scope: :user_id
  validate :different_user

  def best_answer
    Answer.where(question_id: id, best_answer:true)
  end

  def karma
    all_votes = Vote.where(voteable_id: id, voteable_type: "Answer")
    all_votes.sum(:score)
  end

  private

  def different_user
    if self.user == self.question.user
      errors.add(:base, "You can't answer your own question.")
    end
  end
end
