class SessionsController < ApplicationController
	
	def create
		user = User.find_by(email: params[:email])
		if (user && user.authenticate(params[:password]))
			set_session_user user.id
			redirect_to user_path(user.id)
		else
			flash[:warning] = "Either username or password are incorrect."
			redirect_to login_path
		end	
	end

	def destroy
		remove_session_user
		redirect_to root_path
	end

end