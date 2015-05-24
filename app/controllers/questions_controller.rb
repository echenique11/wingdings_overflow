class QuestionsController < ApplicationController
  before_filter :find_question, except: [:index, :new, :create]

  def index
    @questions = Question.questions_by(params[:search_by],params[:description])
  end

  def show
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    tags_array = params[:tags].split(",").map {|tag| tag.strip}
    tags_array.each do |tag|
      @question.tags << Tag.find_or_create_by(tag_name: tag)
    end
    if @question.save
      redirect_to question_path(@question)
    else
      flash[:error] = "That was an invalid question."
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update_attributes(params[:question])
      flash[:success] = "Question updated."
      redirect_to question_path(@question)
    else
      flash[:error] = "That was an invalid question."
      render :edit
    end
  end

  private
  def find_question
    @question = Question.find_by(id: params[:id]) if params[:id]
  end

  def question_params
    params.require(:question).permit(:title, :body).merge(user_id: current_user.id )
  end
end