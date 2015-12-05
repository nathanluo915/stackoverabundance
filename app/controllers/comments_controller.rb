class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render partial: @comment
    else
      @notice = answer.errors.full_messages
      if commentable_type == "Answer"
        @question = Answer.find(params[:comment][:commentable_id]).question
      else
        @question = Question.find(params[:comment][:commentable_id])
      end
      redirect_to question_path(@question)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:commentable_type, :commentable_id, :content).merge(user_id: current_user.id)
  end
end
