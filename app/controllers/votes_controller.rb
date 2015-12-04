class VotesController < ApplicationController

  def create
    @vote = Vote.new(permit_params)
    if @vote.save
      render partial: 'vote', locals: {votable: @vote.votable}
    else
      render text: "You've already voted"
    end
  end

  def update
    @vote = Vote.find(params[:id])
    @vote.upvote = !@vote.upvote
    if @vote.save
      render partial: 'vote', locals: {votable: @vote.votable, vote: @vote}
    else
      render text: "You've already voted"
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy
    render partial: 'vote', locals: {votable: @vote.votable, vote: @vote}
  end

  private

  def permit_params
    params.require(:vote).permit(:user_id, :votable_id, :votable_type, :upvote)
  end
end
