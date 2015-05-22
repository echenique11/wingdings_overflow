class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :user

  validates :score, :user_id, :voteable_type, :votable_id, presence: :true
  validates_uniqueness_of :user_id, scope: [:votable_id, :voteable_type, :score]
  validate :different_user
  validate :one_neg_one

  private

  def different_user
    self.user != question.user
  end

  def one_neg_one
    self.score == 1 || self.score == -1
  end
end
