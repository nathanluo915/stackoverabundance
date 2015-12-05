class VotesController < ApplicationController

  def create
    @vote = Vote.new(permit_params)
    if @vote.save
      respond_to do |format|
        format.html { render partial: 'vote', locals: {votable: @vote.votable}, layout: false }
        format.js { }
      end
    else
      render text: "You've already voted"
    end
  end

  def update
    @vote = Vote.find(params[:id])
    @vote.flip_vote
    if @vote.save
      respond_to do |format|
        format.html { render partial: 'vote', locals: {votable: @vote.votable, vote: @vote}, layout: false }
        format.js { }
      end
    else
      render text: "You've already voted"
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy
    respond_to do |format|
      format.html { render partial: 'vote', locals: {votable: @vote.votable, vote: @vote}, layout: false }
      format.js { }
    end
  end

  private

  def permit_params
    params.require(:vote).permit(:user_id, :votable_id, :votable_type, :upvote)
  end
end
