class User < ActiveRecord::Base
	has_secure_password
	has_many :questions
	has_many :comments

	def questions_by(key, value)
		if(value)
			p "value #{value}"
			return questions.eager_load(:tags).where(["tags.tag_name LIKE ?","%#{value}%"]) if key == "tags"
			questions.where([" title LIKE ?","%#{value}%"])
		else 
			p "no value"
			p questions
			questions
		end
	end

  validates :username, :email, :password, presence: :true
end
