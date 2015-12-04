class QuestionsController < ApplicationController
  def index
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = current_user.questions.new
  end

end
