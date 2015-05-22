class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :user

  validates :score, :user_id, :voteable_type, :voteable_id, presence: :true
  validates_uniqueness_of :user_id, scope: [:voteable_id, :voteable_type, :score]
  validate :different_user
  validate :one_neg_one

  private

  def different_user
    self.user != self.voteable.user
  end

  def one_neg_one
    self.score == 1 || self.score == -1
  end
end
