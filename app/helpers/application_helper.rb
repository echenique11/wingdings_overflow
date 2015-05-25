module ApplicationHelper
	def gravitar(email)
	  Digest::MD5.hexdigest(email.strip.downcase)
	end
end
