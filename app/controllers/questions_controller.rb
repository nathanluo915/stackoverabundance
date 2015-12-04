class QuestionsController < ApplicationController
  def index
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    current_user = User.new(username:"a", email:"a", password:"a")
    @question = current_user.questions.new
  end

  def upvote
    @new_upvote = self.votes.build(user: current_user, upvote: true)
    if @new_upvote.save
      render partial: 'vote'
    end
  end
end
