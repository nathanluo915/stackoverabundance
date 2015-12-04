module Voting
  def total_votes
    self.upvotes - self.downvotes
  end

  def upvotes
    self.votes.where(upvote: true).count
  end

  def downvotes
    self.votes.where(upvote: false).count
  end

  def upvote
    @new_upvote = self.votes.build(user: current_user, upvote: true)
    if @new_upvote.save
      render partial: 'vote'
    end
  end

  def downvote
    @new_downvote = self.votes.build(user: current_user, upvote: false)
    if @new_downvote.save
      render partial: 'vote'
    end
  end
end
