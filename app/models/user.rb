class User < ActiveRecord::Base
	has_secure_password
	has_many :questions
	has_many :comments

	def questions_by(key, value)
		if(value)
			return questions.eager_load(:tags).where(["tags.tag_name LIKE ?","%#{value}%"]) if key == "tags"
			return questions.eager_load(:answers).where("answers.best_answer IS false or answers.question_id IS NULL") if key == "unanswered"
			questions.where([" title LIKE ?","%#{value}%"])
		else 
			questions
		end
	end

  validates :username, :email, :password, presence: :true
end
