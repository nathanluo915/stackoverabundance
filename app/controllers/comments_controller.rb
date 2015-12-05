class CommentsController < ApplicationController
  def new
    render partial: 'form'
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render partial: @comment
    else

    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :commentable_type, :commentable_id, :content)
  end
end
