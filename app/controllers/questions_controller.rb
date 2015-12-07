class QuestionsController < ApplicationController
  def index
    @questions = Question.get_questions_by_newest
  end

  def list
    if params[:selection] == "1" || params[:selection] == nil
      @questions = Question.get_questions_by_newest
    elsif params[:selection] == "2"
      @questions = Question.get_questions_by_highest_voted
    else
      @questions = Question.get_questions_by_highest_voted
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

  def empty_check_mark
    answer = Answer.find(params["answer-id"].to_i)
    render partial: "empty_check_mark", locals: {answer: answer}
  end

  private
  def strong_params
    params.require(:question).permit(:title,:content)
  end


end
