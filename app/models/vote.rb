class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :user

  validates :score, :user_id, :voteable_type, :voteable_id, presence: :true
  validates_uniqueness_of :user_id, scope: [:voteable_id, :voteable_type, :score]
  validate :different_user
  validate :one_neg_one

  private

  def different_user
    if self.user == self.voteable.user
      errors.add(:base, "You can't vote on your own question.")
    end
  end

  def one_neg_one
    if !(self.score == 1 || self.score == -1)
      errors.add(:base, "That is an illegal vote.")
    end
  end
end
