class AnswersController < ApplicationController
  before_filter :find_answer, except: [:create]

    def create
      @answer = Answer.new(answer_params)
      if @answer.save
        redirect_to question_path(@answer.question)
      else
        flash[:warning] = "Could not save answer please try again."
        redirect_to :back
      end
    end

    def edit
    end

    def update
        if @answer.update_attributes(answer_params)
        flash[:success] = "Answer update saved"
        redirect_to question_path(@answer.question)
      else
        flash[:warning] = "Unable to update answer"
        render :edit
      end
    end

    private

    def find_answer
      @answer = Answer.find_by(id: params[:id]) if params[:id]
    end

    def answer_params
      params.permit(:body, :question_id).merge(user_id: current_user.id )
    end
end