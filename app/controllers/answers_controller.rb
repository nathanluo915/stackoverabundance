class AnswersController < ApplicationController
  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
    render partial: 'form'
  end

  def create
    @question = Question.find(params[:question_id])
    answer = @question.answers.build(answer_build_params)
    if answer.save
      render partial: answer
    else
      @notice = answer.errors.full_messages
      render question_path(@queston)
    end
  end

  private
  def answer_build_params
    params.require(:answer).permit(:user_id, :content)
  end
end
