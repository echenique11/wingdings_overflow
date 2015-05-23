class User < ActiveRecord::Base
	has_secure_password
	has_many :questions
	has_many :comments

	def questions_by(key, value)
			questions.where(["#{key} = ? ",value])
	end

  validates :username, :email, :password, presence: :true
end
