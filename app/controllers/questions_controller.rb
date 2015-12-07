class QuestionsController < ApplicationController
  before_action :ensure_someone_logged_in, only: [:new, :create, :update, :destroy]

  def index
    @questions = Question.get_questions_by_newest
  end

  NEWEST = "1"
  HIGHEST_VOTED = "2"

  def list
    # Use meaningful constants rather than "1" "2" etc here
    if params[:selection] == NEWEST || params[:selection] == nil
      @questions = Question.get_questions_by_newest
    elsif params[:selection] == HIGHEST_VOTED
      @questions = Question.get_questions_by_highest_voted
    else
      @questions = Question.get_questions_by_trending
    end
    render partial: 'questions', locals:{questions: @questions}
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = current_user.questions.new
    render partial: 'new', locals: {questions: @questions}
  end

  def create
   q = current_user.questions.new(strong_params)
   if q.save
    if request.xhr?
      render text: "Success"
    else
      redirect_to root_path
    end
    #Think about what if this request was not xhr but does fail
   else
     render json: q.errors.full_messages
   end
  end

  def update
    @question = Question.find(params[:id])
    @question.best_answer = Answer.find(params[:question][:answer_id])
    if @question.save
      render partial: "best_answer_form", locals: {answer: @question.best_answer}
    else
      flash[:notice] = "Answer does not exist"
      render @question
    end
  end

  #Think about having this invisible in the DOM rather than calling for it over the network
  def empty_check_mark
    answer = Answer.find(params["answer-id"].to_i)
    render partial: "empty_check_mark", locals: {answer: answer}
  end

  private
  def strong_params
    params.require(:question).permit(:title,:content)
  end


end
