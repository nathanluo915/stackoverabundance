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
    current_user = User.new(username:"a", email:"a", password:"a")
    @question = current_user.questions.new
  end

  def create
   q = current_user.questions.new(strong_params)
   if q.save
    redirect_to root_path
   else
    errors.add("Form not completed properly")
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
