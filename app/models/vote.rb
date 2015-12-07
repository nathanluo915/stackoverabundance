class Vote < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :votable, polymorphic: true

  validates :user, uniqueness: { scope: [:votable_type, :votable_id],
    message: "You may only vote once per question. If you are seeing this message, you have attempted vote manipulation, which is against our community guidelines. If you believe you are seeing this message by mistake, please contact our team at admin@stackoverabundance.com to prevent your account from being banned."}
 

  # Name this something like self.user_vote_for(user, votable)
  def self.your_vote(a_user, votable)
    Vote.find_by(user: a_user, votable: votable)
  end

  def flip_vote
    self.upvote = !self.upvote
  end
end
