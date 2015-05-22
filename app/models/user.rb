class User < ActiveRecord::Base
	has_secure_password
	has_many :questions
	has_many :comments

  validates :username, :emial, :password, presence: :true
end
