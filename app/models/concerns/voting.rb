module Voting
  def total_votes
    (self.upvotes - self.downvotes).to_s
  end

  def upvotes
    self.votes.where(upvote: true).count
  end

  def downvotes
    self.votes.where(upvote: false).count
  end
end
