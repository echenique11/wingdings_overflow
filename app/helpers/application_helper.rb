module ApplicationHelper
	def gravitar(email)
	  hash = Digest::MD5.hexdigest(email.strip.downcase)
	  "<img id='profile-photo' src='http://www.gravatar.com/avatar/#{hash}'>"
	end
end
