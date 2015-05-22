class UsersController < ApplicationController

	before_action :set_user

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			set_session_user @user.id
			redirect_to user_path(@user.id)
		else
			flash[:warning] = "Couldn't create a user"
			render :new
		end
	end

	def show
		@question_data = @user.questions.map do |question|
			Hash[title: question.title,
				answers: question.answers.count, 
				comments: question.comments.count, 
				votes: question.votes.count,
				karma: question.karma]
		end
		
	end

	def edit
	end

	def update
		@user.update_attributes(user_params)
		if @user.save
			redirect_to user_path(@user.id)
		else
			render :edit
		end
	end

	private

	def set_user
		@user = User.find_by(id: params[:id])
	end

	def user_params
		params.require(:user).permit(:username,:email,:password)
	end

end