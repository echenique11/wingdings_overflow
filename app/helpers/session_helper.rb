module SessionHelper
	def current_user
		User.find_by(id: session[:user_id])
	end

	def is_authenticated?
		session.has_key? :user_id
	end

	def remove_session_user
		session.delete(:user_id)
	end

	def set_session_user user_id
		session[:user_id] = user_id
	end
end
