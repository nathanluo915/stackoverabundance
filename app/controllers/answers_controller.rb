class AnswersController < ApplicationController
  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
    render partial: 'form'
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_build_params)
    if @answer.save
      render partial: @answer
    else
      #This looks like an ajax only method? Redirect won't do anthing.
      # You should return a 422 error code on failure so that your ajax.fail handler fires
      @notice = @answer.errors.full_messages
      redirect_to question_path(@question)
    end
  end

  private
  def answer_build_params
    params.require(:answer).permit(:content).merge(user_id: current_user.id)
  end
end
