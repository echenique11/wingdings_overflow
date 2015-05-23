class Question < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :answers
  has_many :comments, as: :commentable
  has_many :votes, as: :voteable

  validates :title, :body, :user_id, presence: :true

  accepts_nested_attributes_for :tags
  def karma
    all_votes = Vote.where(voteable_id: id, voteable_type: "Question")
    all_votes.sum(:score)
  end

  scope :questions_by, -> (key, value) do
    if(value || key == "unanswered")
      return self.eager_load(:tags).where(["tags.tag_name LIKE ?","%#{value}%"]) if key == "tags"
      return self.eager_load(:answers).where("answers.question_id IS NULL") if key == "unanswered"
      self.where([" title LIKE ?","%#{value}%"])
    else 
      self.all
    end
  end
end