class QuestionsController < ApplicationController
  def index
    @questions = Question.get_questions_by_newest
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

  def create
   q = current_user.questions.new(strong_params)
   if q.save
    redirect_to :index
   else
    errors.add("Form not completed properly")
   end
  end


  def strong_params
    params.require(:question).permit(:title,:content)
  end


end
